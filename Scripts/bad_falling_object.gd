extends CharacterBody2D
@onready var ObjectAnimation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready()->void:
	ObjectAnimation.play("cage")
	randpos()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity = get_gravity()/3

	if position.y>1000:
		randpos()
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
		Globals.fallhealth-=1
		randpos()
		Globals.fallCut=true;
		
func randpos():
	position.x = randi_range(830,980)
	position.y = randi_range(0,-500)
