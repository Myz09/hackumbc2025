extends Node

# Singleton script for managing scene transitions with loading screens
# Add this as an autoload in Project Settings > AutoLoad

var loading_screen_scene: PackedScene
var current_loading_screen: Control

func _ready():
	# Load the loading screen scene
	loading_screen_scene = preload("res://loading_screen.tscn")

func load_scene_with_loading(scene_path: String):
	"""Load a scene with the loading screen"""
	print("Loading scene: ", scene_path)
	
	# Create and show loading screen
	show_loading_screen()
	
	# Start loading the target scene
	ResourceLoader.load_threaded_request(scene_path)
	
	# Wait for loading to complete
	await _wait_for_scene_loaded(scene_path)
	
	# Get the loaded scene
	var loaded_scene = ResourceLoader.load_threaded_get(scene_path)
	if loaded_scene:
		# Change to the new scene
		get_tree().change_scene_to_packed(loaded_scene)
	else:
		print("Error: Failed to load scene: ", scene_path)
		hide_loading_screen()

func show_loading_screen():
	"""Show the loading screen"""
	if current_loading_screen:
		current_loading_screen.queue_free()
	
	current_loading_screen = loading_screen_scene.instantiate()
	get_tree().root.add_child(current_loading_screen)
	
	# Make it the current scene temporarily
	get_tree().current_scene = current_loading_screen

func hide_loading_screen():
	"""Hide the loading screen"""
	if current_loading_screen:
		current_loading_screen.queue_free()
		current_loading_screen = null

func _wait_for_scene_loaded(scene_path: String):
	"""Wait for a scene to finish loading"""
	while ResourceLoader.load_threaded_get_status(scene_path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame

# Static methods for easy access from anywhere
static func load_scene(scene_path: String):
	"""Static method to load a scene with loading screen"""
	var manager = get_tree().get_first_node_in_group("scene_transition_manager")
	if not manager:
		manager = get_node("/root/SceneTransitionManager")
	if manager:
		manager.load_scene_with_loading(scene_path)
	else:
		print("Error: SceneTransitionManager not found!")

static func load_level_1():
	"""Load Level 1: Forest Floor"""
	load_scene("res://level_1_forest_floor.tscn")

static func load_level_2():
	"""Load Level 2: Understory"""
	load_scene("res://level_2_understory.tscn")

static func load_level_3():
	"""Load Level 3: Canopy"""
	load_scene("res://level_3_canopy.tscn")

static func load_level_4():
	"""Load Level 4: Emergent Layer"""
	load_scene("res://level_4_emergent_layer.tscn")

static func load_main_menu():
	"""Load the main menu"""
	load_scene("res://main_menu.tscn")
