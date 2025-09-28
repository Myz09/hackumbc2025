extends Node3D

@onready var back_to_menu_button: Button = $UI/VBoxContainer/BackToMenuButton

func _ready():
	print("🎮 Simple Arcade Scene Loaded! Welcome to Big Mac's Rainforest Escape!")
	
	# Connect button signals
	back_to_menu_button.pressed.connect(_on_back_to_menu_pressed)

func _on_back_to_menu_pressed():
	"""Return to main menu"""
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _input(event):
	"""Handle input for the game"""
	if event.is_action_pressed("ui_cancel"):  # ESC key
		# Return to main menu
		_on_back_to_menu_pressed()
