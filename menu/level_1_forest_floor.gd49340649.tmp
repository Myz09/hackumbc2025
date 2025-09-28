extends Node3D

@onready var back_to_menu_button: Button = $UI/VBoxContainer/BackToMenuButton
@onready var next_level_button: Button = $UI/VBoxContainer/NextLevelButton

func _ready():
	# Connect button signals
	back_to_menu_button.pressed.connect(_on_back_to_menu_pressed)
	next_level_button.pressed.connect(_on_next_level_pressed)
	
	# Set up the forest floor environment
	setup_environment()

func setup_environment():
	"""Set up the forest floor environment"""
	# This is where you would add your forest floor specific elements
	# For now, we have basic trees and ground
	
	# You can add more environmental elements here:
	# - Fallen logs
	# - Fungi
	# - Decomposing matter
	# - Big Mac character
	# - Collectible nuts
	# - Platforming elements
	
	print("Welcome to the Forest Floor - Level 1 of Big Mac's Rainforest Escape!")

func _on_back_to_menu_pressed():
	"""Return to main menu with loading screen"""
	# Load the loading screen directly
	var loading_scene = preload("res://loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading_scene)
	loading_scene.load_scene("res://main_menu.tscn")

func _on_next_level_pressed():
	"""Load next level (Understory) with loading screen"""
	# For now, just show a message since we haven't created Level 2 yet
	print("Level 2: Understory coming soon!")
	# SceneTransitionManager.load_level_2()

func _input(event):
	"""Handle input for the level"""
	# Add your game controls here
	# For example:
	# if event.is_action_pressed("jump"):
	#     # Handle jump
	# if event.is_action_pressed("move_left"):
	#     # Handle left movement
	# etc.
	pass
