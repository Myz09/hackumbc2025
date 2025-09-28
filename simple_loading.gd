extends Control

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressContainer/ProgressBar
@onready var progress_label: Label = $VBoxContainer/ProgressContainer/ProgressLabel
@onready var tip_label: Label = $VBoxContainer/LoadingTips/TipLabel

var loading_tips: Array[String] = [
	"Tip: The rainforest has four distinct layers to explore!",
	"Tip: Collect nuts throughout your journey for points!",
	"Tip: Each layer presents unique platforming challenges!",
	"Tip: Big Mac must reach the emergent layer to escape!",
	"Tip: Watch out for obstacles on the forest floor!",
	"Tip: The canopy is where most rainforest life thrives!",
	"Tip: Help Big Mac escape the deforestation threat!",
	"Tip: Learn about rainforest conservation through gameplay!"
]

var current_tip_index: int = 0
var target_scene: String = "res://simple_arcade.tscn"
var actual_loading_progress: float = 0.0

func _ready():
	# Set up the loading screen
	start_loading_animation()
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
	current_tip_index = (current_tip_index + 1) % loading_tips.size()
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
