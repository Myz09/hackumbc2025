extends Control

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressContainer/ProgressBar
@onready var progress_label: Label = $VBoxContainer/ProgressContainer/ProgressLabel
@onready var tip_label: Label = $VBoxContainer/LoadingTips/TipLabel

var loading_tips: Array[String] = [
	# Shocking Deforestation Statistics
	"The tropics lost a record 6.7 million hectares of primary rainforest in 2024 - nearly the size of Panama!",
	"18.7 million acres of forest are lost globally every year - that's 51,000 acres per day!",
	"About 27 soccer fields of rainforest are destroyed every single minute!",
	"80% of global deforestation is linked to agriculture for crops and livestock.",
	"Deforestation accounts for about 7% of global emissions.",
	
	# Big Mac's Species in Danger
	"Most of the 17 species of macaws are endangered or extinct due to deforestation!",
	"The last known wild Spix's macaw died in 2000 - only 90 exist in captivity worldwide.",
	"Less than 50 Glaucous Macaws remain in the wild.",
	"Only about 2,000 Scarlet Macaws exist in Costa Rica.",
	"77% of captured parrots die during capture and transport to the pet trade.",
	
	# Rainforest Layer Facts
	"Only 2% of sunlight reaches the forest floor where Big Mac starts his journey!",
	"5% of sunlight filters to the understory - most wildlife lives here!",
	"90% of rainforest species live in the canopy layer!",
	"The canopy forms a 'roof' 60-130 feet above the forest floor.",
	"Rainforests produce 20% of Earth's oxygen!",
	
	# Conservation Hope
	"Deforestation rates declined by 49.5% in Brazil's first 9 months of 2023!",
	"One rainforest tree can be home to over 400 insect species.",
	"Macaws can live up to 100 years in the wild.",
	"137 species are lost to deforestation every single day.",
	"Support FSC-certified wood products to help protect rainforests!",
	
	# Gameplay Integration
	"Big Mac struggles in the darkness - just like real forest floors!",
	"Navigate through dense growth like real rainforest animals!",
	"Big Mac finally reaches home... but is it still there?",
	"Like Big Mac, real rainforest species need our help!",
	"Every tree cut down destroys someone's home."
]

var current_tip_index: int = 0
var target_scene: String = "res://simple_arcade.tscn"
var actual_loading_progress: float = 0.0

func _ready():
	# Set up the loading screen
	start_loading_animation()
	
	# Show initial random tip
	current_tip_index = randi() % loading_tips.size()
	tip_label.text = loading_tips[current_tip_index]
	
	start_tip_rotation()
	start_loading()

func start_loading_animation():
	# Simple tip rotation
	pass

func start_tip_rotation():
	# Rotate through loading tips
	var tip_tween = create_tween()
	tip_tween.set_loops()
	tip_tween.tween_callback(update_tip).set_delay(3.0)

func update_tip():
	# Randomly select a new tip (avoid repeating the same one)
	var new_index = current_tip_index
	while new_index == current_tip_index and loading_tips.size() > 1:
		new_index = randi() % loading_tips.size()
	current_tip_index = new_index
	tip_label.text = loading_tips[current_tip_index]

func start_loading():
	# Start actually loading the scene in the background
	ResourceLoader.load_threaded_request(target_scene)
	
	# Update progress based on actual loading
	update_loading_progress()

func update_loading_progress():
	# Check actual loading progress
	var status = ResourceLoader.load_threaded_get_status(target_scene)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		# Still loading, update progress faster
		actual_loading_progress = min(actual_loading_progress + 10.0, 95.0)  # Faster progress
		progress_bar.value = actual_loading_progress
		progress_label.text = str(int(actual_loading_progress)) + "%"
		
		# Check again next frame
		await get_tree().process_frame
		update_loading_progress()
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		# Scene is loaded, complete the loading
		on_loading_complete()
	else:
		# Error loading, fallback to direct loading
		print("Error loading scene, using fallback")
		on_loading_complete()

func on_loading_complete():
	# Ensure we're at 100%
	progress_bar.value = 100.0
	progress_label.text = "100%"
	
	# Brief delay before transitioning
	await get_tree().create_timer(0.5).timeout
	
	# Try to load the arcade scene
	var loaded_scene = ResourceLoader.load_threaded_get(target_scene)
	if loaded_scene:
		get_tree().change_scene_to_packed(loaded_scene)
	else:
		# Fallback to simple arcade scene if main arcade fails
		print("Main arcade scene failed to load, using simple arcade scene")
		get_tree().change_scene_to_file("res://simple_arcade.tscn")
