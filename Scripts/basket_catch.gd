extends Node2D
@onready var pause_menu = $Pausemenu
@onready var score = $Score
@onready var health =$Health
var paused = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text="Score: " +  str(Globals.fallScore);
	health.text="Health: " +  str(Globals.fallhealth);
	if (Globals.fallhealth<=0):
		get_tree().change_scene_to_file("res://cut_screen.tscn")
		Globals.fallhealth=3
		Globals.fallScore=0
	
		
#func pauseMenu():
	#if paused:
		#pause_menu.hide()
		#Engine.time_scale=1
	#else:
		#pause_menu.show()
		#Engine.time_scale=0;
	#paused = !paused
