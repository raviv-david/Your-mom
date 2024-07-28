extends CharacterBody2D

const SPEED = 700
const MAX_SPEED = 120
const JUMP_VELOCITY = -190
const DOUBLE_JUMP_VELOCITY_MULIPLIER = 0.85
const MAX_FALLING_SPEED = 800
const GRAVITY = 450

var on_floor = true
var jumps = 2
var direction = 0

func _physics_process(delta):
	print(velocity.x)
	maintenance(delta)
	
	# Handle jump
	handle_jump()
	
	# Handle movement
	handle_monement(delta)
	
	# Move
	move_and_slide()

func maintenance(delta):
	on_floor = is_on_floor()
	
	# Get movement direction input
	direction = Input.get_axis("moveLeft", "moveRight")
	
	# Reset jumps
	if on_floor: 
		jumps = 2
	
	 # Apply gravity
	if !on_floor:
		velocity.y += GRAVITY * delta
		velocity.y = clamp(velocity.y, -99999, 175)

func handle_jump():
	if Input.is_action_just_pressed("moveJump"):
		match jumps:
			2:
				velocity.y = JUMP_VELOCITY
			1:
				velocity.y = JUMP_VELOCITY * DOUBLE_JUMP_VELOCITY_MULIPLIER
		jumps -= 1

func handle_monement(delta):
	if direction != 0:
		if !on_floor: # accelerate slower in the air
			velocity.x += ((direction * SPEED) / 3) * delta
		else:
			if((velocity.x != 0 && direction < 0) || (velocity.x < 0 && direction > 0)):# rapidy slow down if character is changing direction
				velocity.x = move_toward(velocity.x, 0, SPEED/100)
			velocity.x += (direction * SPEED) * delta # apply speed
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		
		if $AnimatedSprite2D: # Adjust character sprite direction
			$AnimatedSprite2D.flip_h = direction < 0
	else: # Deceleration
		if on_floor:
			velocity.x = move_toward(velocity.x, 0, SPEED/50)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED/250)
