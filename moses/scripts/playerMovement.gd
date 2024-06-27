extends CharacterBody2D



const SPEED = 220.0
const JUMP_VELOCITY = -350.0

var jumps = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		jumps = 1
		
	# Handle jump.
	if Input.is_action_just_pressed("moveJump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/13)

	move_and_slide()
