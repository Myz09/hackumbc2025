extends CharacterBody2D
@onready var PlayerAnimation = $PlayerAnimation


const SPEED = 300.0

func _ready()->void:
	PlayerAnimation.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		PlayerAnimation.flip_h = true
	elif direction < 0:
		PlayerAnimation.flip_h = false
	move_and_slide()
