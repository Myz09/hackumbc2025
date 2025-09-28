extends CharacterBody2D
@onready var PlayerAnimation = $PlayerAnimation

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

func _ready():
	PlayerAnimation.play("idle");
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		PlayerAnimation.play("fall")
	else:
		PlayerAnimation.play("idle")
		
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		PlayerAnimation.play("jump")
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	#if moving: speed
	if direction:
		velocity.x = direction * SPEED
	else: #else: no speed
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#if direction>0:
		#PlayerAnimation.flip_h=true
	#else:
		#PlayerAnimation.flip_h=false
		
	if direction > 0:
		PlayerAnimation.flip_h = true
	elif direction < 0:
		PlayerAnimation.flip_h = false
	
	move_and_slide()
