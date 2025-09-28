extends Control

signal loading_complete

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressContainer/ProgressBar
@onready var progress_label: Label = $VBoxContainer/ProgressContainer/ProgressLabel
@onready var tip_label: Label = $VBoxContainer/LoadingTips/TipLabel
@onready var floating_leaves: Node2D = $AnimatedElements/FloatingLeaves
@onready var spinning_leaf: ColorRect = $AnimatedElements/LoadingAnimation/SpinningLeaf

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
var loading_progress: float = 0.0
var target_scene: String = ""
var loading_speed: float = 1.0

func _ready():
	# Set up the loading screen
	setup_animations()
	start_loading_animation()
	
	# Show initial random tip
	current_tip_index = randi() % loading_tips.size()
	tip_label.text = loading_tips[current_tip_index]
	
	start_tip_rotation()
	
	# Start loading process
	start_loading()

func setup_animations():
	# Create floating animation for leaves
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(50, -30), 3.0)
	tween.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(-30, 20), 2.0)
	tween.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(20, 10), 2.5)
	tween.tween_property(floating_leaves, "position", floating_leaves.position, 2.0)
	
	# Create spinning animation for the loading indicator
	var spin_tween = create_tween()
	spin_tween.set_loops()
	spin_tween.tween_property(spinning_leaf, "rotation", spinning_leaf.rotation + TAU, 2.0)

func start_loading_animation():
	# Animate individual leaves
	var leaves = floating_leaves.get_children()
	for i in range(leaves.size()):
		var leaf = leaves[i]
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property(leaf, "modulate:a", 0.3, 1.5 + i * 0.3)
		tween.tween_property(leaf, "modulate:a", 0.8, 1.5 + i * 0.3)

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
	
	# Fade effect for tip changes
	var fade_tween = create_tween()
	fade_tween.tween_property(tip_label, "modulate:a", 0.0, 0.3)
	fade_tween.tween_callback(func(): tip_label.text = loading_tips[current_tip_index])
	fade_tween.tween_property(tip_label, "modulate:a", 1.0, 0.3)

func start_loading():
	# Simulate loading progress
	var loading_tween = create_tween()
	loading_tween.tween_method(update_progress, 0.0, 100.0, 3.0)
	loading_tween.tween_callback(on_loading_complete)

func update_progress(value: float):
	loading_progress = value
	progress_bar.value = value
	progress_label.text = str(int(value)) + "%"
	
	# Add some randomness to make it feel more realistic
	if randf() < 0.1:  # 10% chance each frame
		progress_bar.value = min(progress_bar.value + randf() * 5, 100.0)

func on_loading_complete():
	# Ensure we're at 100%
	progress_bar.value = 100.0
	progress_label.text = "100%"
	
	# Brief delay before transitioning
	await get_tree().create_timer(0.5).timeout
	
	# Emit signal that loading is complete
	loading_complete.emit()

func load_scene(scene_path: String):
	"""Load a specific scene with loading screen"""
	target_scene = scene_path
	loading_complete.connect(_on_loading_complete)
	
	# Show loading screen
	get_tree().current_scene = self
	
	# Start loading the target scene in background
	ResourceLoader.load_threaded_request(scene_path)

func _on_loading_complete():
	"""Handle loading completion and scene transition"""
	if target_scene != "":
		# Get the loaded scene
		var loaded_scene = ResourceLoader.load_threaded_get(target_scene)
		if loaded_scene:
			# Change to the new scene
			get_tree().change_scene_to_packed(loaded_scene)
		else:
			print("Error: Failed to load scene: ", target_scene)

# Static method to easily show loading screen
static func show_loading_screen(scene_path: String):
	"""Static method to show loading screen and load a scene"""
	var loading_scene = preload("res://loading_screen.tscn").instantiate()
	# Note: This static method needs to be called from a node context
	# For now, we'll use the SceneTransitionManager instead
	print("Use SceneTransitionManager.load_scene() instead of this static method")
