extends Area2D


func _on_body_entered(sbody:Node2D) -> void:
	Globals.alive=false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#extends Area2D
#
#@onready var timer: Timer = $Timer
#
#func _on_body_entered(body: Node2D) -> void:
	#Globals.alive = false
	#Engine.time_scale = 0.5
	#body.get_node("CollisionShape2D").queue_free()
	#body.get_node(".").gravity = 0
	#timer.start()
#
#
#func _on_timer_timeout() -> void:
	#Engine.time_scale = 1.0
	#Globals.current_goombas = 0
	#get_tree().reload_current_scene()
	#Globals.alive = true
