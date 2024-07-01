extends CharacterBody2D

const SPEED = 500
const MAX_SPEED = 130
const JUMP_VELOCITY = -193
const MAX_FALLING_SPEED = 650
const GRAVITY = 450

var jumps = 1

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = clamp(velocity.y, -99999, 175)
	
	if is_on_floor(): 
		jumps = 2
	
	# Handle jump
	if Input.is_action_just_pressed("moveJump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction != 0:
		if !is_on_floor():
			velocity.x += ((direction * SPEED) / 2) * delta
		else:
			if(velocity.x > 0 && direction < 0):
				velocity.x = move_toward(velocity.x, 0, SPEED/100)
				print("Slowing down1")
			elif(velocity.x < 0 && direction > 0):
				#velocity.x = move_toward(velocity.x, 0, SPEED/100)
				print("Slowing down2")
			velocity.x += (direction * SPEED) * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		
		# Adjust character sprite direction
		if $Sprite2D:
			$Sprite2D.flip_h = direction < 0
	else: # Deceleration
		velocity.x = move_toward(velocity.x, 0, SPEED/50)
	
	# Apply movement
	move_and_slide()
