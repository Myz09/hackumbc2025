extends CharacterBody2D
@onready var ObjectAnimation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var nuts = ["Walnut", "Peanut", "Pistachio", "Pecan", "Almond"]

func _ready()->void:
	randpos()
	ObjectAnimation.play(nuts[randi_range(0,4)])
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity = get_gravity()/3

	if position.y>1000:
		randpos()
		ObjectAnimation.play(nuts[randi_range(0,4)])
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
		Globals.fallScore+=1
		randpos()
		
func randpos():
	position.x = randi_range(830,980)
	position.y = randi_range(0,-500)
