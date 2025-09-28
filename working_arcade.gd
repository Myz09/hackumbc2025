extends Node3D

@onready var ui: Control = $UI
@onready var back_to_menu_button: Button = $UI/VBoxContainer/BackToMenuButton
@onready var floor_mesh: MeshInstance3D = $Floor/FloorMesh
@onready var arcade_mesh: MeshInstance3D = $ArcadeMachine/ArcadeMesh

func _ready():
	print("🎮 Working Arcade Scene Loaded! Welcome to Big Mac's Rainforest Escape!")
	setup_arcade_environment()
	
	# Connect button signals
	back_to_menu_button.pressed.connect(_on_back_to_menu_pressed)

func setup_arcade_environment():
	"""Set up the arcade environment with proper materials"""
	# Set up floor material (forest green)
	var floor_material = StandardMaterial3D.new()
	floor_material.albedo_color = Color(0.2, 0.4, 0.1)  # Forest green
	floor_mesh.material_override = floor_material
	
	# Set up arcade machine material (dark blue/black)
	var arcade_material = StandardMaterial3D.new()
	arcade_material.albedo_color = Color(0.1, 0.1, 0.3)  # Dark blue
	arcade_mesh.material_override = arcade_material
	
	print("🌳 Arcade environment set up! Ready for Big Mac's adventure!")

func _on_back_to_menu_pressed():
	"""Return to main menu"""
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _input(event):
	"""Handle input for the game"""
	if event.is_action_pressed("ui_cancel"):  # ESC key
		# Return to main menu
		_on_back_to_menu_pressed()
	
	# Add your game controls here
	# For example:
	# if event.is_action_pressed("jump"):
	#     # Handle jump
	# if event.is_action_pressed("move_left"):
	#     # Handle left movement
