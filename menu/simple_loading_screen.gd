extends Control

signal loading_complete

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressContainer/ProgressBar
@onready var progress_label: Label = $VBoxContainer/ProgressContainer/ProgressLabel
@onready var tip_label: Label = $VBoxContainer/LoadingTips/TipLabel
@onready var floating_leaves: Node2D = $AnimatedElements/FloatingLeaves
@onready var spinning_leaf: ColorRect = $AnimatedElements/LoadingAnimation/SpinningLeaf

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
var loading_progress: float = 0.0
var target_scene: String = ""

func _ready():
	# Set up the loading screen
	setup_animations()
	start_loading_animation()
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
	current_tip_index = (current_tip_index + 1) % loading_tips.size()
	tip_label.text = loading_tips[current_tip_index]
	
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

func _on_loading_complete():
	"""Handle loading completion and scene transition"""
	if target_scene != "":
		# Load the scene directly
		get_tree().change_scene_to_file(target_scene)
