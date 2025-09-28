extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var level_select_button: Button = $VBoxContainer/LevelSelectButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var floating_leaves: Node2D = $AnimatedElements/FloatingLeaves
@onready var floating_leaves2: Node2D = $AnimatedElements/FloatingLeaves2

func _ready():
	# Connect button signals
	play_button.pressed.connect(_on_play_button_pressed)
	level_select_button.pressed.connect(_on_level_select_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Start background animations
	setup_animations()
	
	# Focus the play button for better UX
	play_button.grab_focus()

func setup_animations():
	# Create floating animation for first set of leaves
	var tween1 = create_tween()
	tween1.set_loops()
	tween1.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(30, -20), 4.0)
	tween1.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(-20, 15), 3.0)
	tween1.tween_property(floating_leaves, "position", floating_leaves.position + Vector2(15, 5), 3.5)
	tween1.tween_property(floating_leaves, "position", floating_leaves.position, 2.5)
	
	# Create floating animation for second set of leaves
	var tween2 = create_tween()
	tween2.set_loops()
	tween2.tween_property(floating_leaves2, "position", floating_leaves2.position + Vector2(-25, 18), 3.5)
	tween2.tween_property(floating_leaves2, "position", floating_leaves2.position + Vector2(18, -12), 2.8)
	tween2.tween_property(floating_leaves2, "position", floating_leaves2.position + Vector2(-12, 8), 3.2)
	tween2.tween_property(floating_leaves2, "position", floating_leaves2.position, 2.2)
	
	# Animate individual leaves with opacity changes
	animate_leaves(floating_leaves)
	animate_leaves(floating_leaves2)

func animate_leaves(leaf_container: Node2D):
	var leaves = leaf_container.get_children()
	for i in range(leaves.size()):
		var leaf = leaves[i]
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property(leaf, "modulate:a", 0.4, 2.0 + i * 0.4)
		tween.tween_property(leaf, "modulate:a", 0.8, 2.0 + i * 0.4)

func _on_play_button_pressed():
	"""Start the game from the arcade scene"""
	print("Starting adventure! Loading arcade scene...")
	# Load the simple loading screen
	get_tree().change_scene_to_file("res://simple_loading_screen.tscn")

func _on_level_select_button_pressed():
	"""Open level selection menu"""
	# For now, just show a message. You can create a level select scene later
	print("Level selection coming soon!")

func _on_quit_button_pressed():
	"""Quit the game"""
	get_tree().quit()

func _input(event):
	# Handle keyboard navigation
	if event.is_action_pressed("ui_accept"):
		if play_button.has_focus():
			_on_play_button_pressed()
		elif level_select_button.has_focus():
			_on_level_select_button_pressed()
		elif quit_button.has_focus():
			_on_quit_button_pressed()
