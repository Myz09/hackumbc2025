extends Node3D
@export var model: MeshInstance3D
@export var area: Area3D
@onready var light = $OmniLight3D
#var highlight_mat: StandardMaterial3D =\
	#preload('res://art/materials/highlight.tres')
#var materials: Array[StandardMatrial3D]

func _ready():
	light.visible = false
	
#func toggle_highlight(on: bool):
	#for i in materials.size():
		#model.set_surface_override_material(i, highlight_mat if on else materials[i])


# Called when the node enters the scene tree for the first time.
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_console_menu_shape_mouse_entered() -> void:
	light.visible = true
	


func _on_console_menu_shape_body_exited(body: Node3D) -> void:
	light.visible = false


func _on_console_menu_shape_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.
