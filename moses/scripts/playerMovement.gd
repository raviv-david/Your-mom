extends CharacterBody2D

const SPEED = 700
const MAX_SPEED = 130
const JUMP_VELOCITY = -190
const MAX_FALLING_SPEED = 650
const GRAVITY = 450

@export var DOUBLE_JUMP = false

var may_jump = false


func _physics_process(delta):
	 # Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = clamp(velocity.y, -99999, 175)
	
	if is_on_floor(): 
		may_jump = true
	
	# Handle jump
	if Input.is_action_just_pressed("moveJump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			if !DOUBLE_JUMP:
				may_jump = false
		elif may_jump:
			velocity.y = JUMP_VELOCITY
			may_jump = false
			
		
		
	# handle movement
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction != 0:
		if !is_on_floor():
			velocity.x += ((direction * SPEED) / 2) * delta
		else:
			if(velocity.x > 0 && direction < 0):
				velocity.x = move_toward(velocity.x, 0, SPEED/100)
			elif(velocity.x < 0 && direction > 0):
				velocity.x = move_toward(velocity.x, 0, SPEED/100)
			velocity.x += (direction * SPEED) * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		
		# Adjust character sprite direction
		if $AnimatedSprite2D:
			$AnimatedSprite2D.flip_h = direction < 0
	else: # Deceleration
		velocity.x = move_toward(velocity.x, 0, SPEED/50)
		
	# Apply movement
	move_and_slide()
