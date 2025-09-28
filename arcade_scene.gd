extends Node3D

@onready var ui: Control = $UI
@onready var back_to_menu_button: Button = $UI/VBoxContainer/BackToMenuButton

func _ready():
	print("🎮 Arcade Scene Loaded! Welcome to Big Mac's Rainforest Escape!")
	setup_arcade_environment()
	
	# Connect button signals
	back_to_menu_button.pressed.connect(_on_back_to_menu_pressed)

func setup_arcade_environment():
	"""Set up the arcade environment for Big Mac's adventure"""
	# This is where you'll build your actual game
	# For now, let's add some basic elements
	
	# Add a simple ground plane
	var ground = MeshInstance3D.new()
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(20, 20)
	ground.mesh = plane_mesh
	ground.material_override = StandardMaterial3D.new()
	ground.material_override.albedo_color = Color(0.2, 0.4, 0.1)  # Forest green
	add_child(ground)
	
	# Add a camera
	var camera = Camera3D.new()
	camera.position = Vector3(0, 5, 10)
	camera.look_at(Vector3.ZERO, Vector3.UP)
	add_child(camera)
	
	# Add some basic lighting
	var light = DirectionalLight3D.new()
	light.position = Vector3(0, 10, 0)
	light.rotation_degrees = Vector3(-45, 0, 0)
	add_child(light)
	
	print("🌳 Forest environment set up! Ready for Big Mac's adventure!")

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
