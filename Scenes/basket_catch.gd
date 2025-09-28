extends Node2D
@onready var pause_menu = $Pausemenu
var paused = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.fallCut==true:
		pauseMenu()
		Globals.fallCut==false;
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale=1
	else:
		pause_menu.show()
		Engine.time_scale=0;
	paused = !paused
