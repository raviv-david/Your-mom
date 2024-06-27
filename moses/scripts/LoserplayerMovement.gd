extends CharacterBody2D

var MAX_VELOCITY = 9

var SLOWING_SPEED = 1.09

var acceleration = 8
var speed = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	# processes player movement input
	var keyPressed = processKeyPress(delta)
	
	# slows the player down if hes not trying to move
	if (!keyPressed[0]):
		slowDown()
	
	position.x += speed
	
	# causes the player to slow down quicker if he's pressing the button opposite to the current movement
	if (keyPressed[0]):
		if ((keyPressed[1] == 'd' && speed < -0.1) or (keyPressed[1] == 'a' && speed > 0.1)):
			slowDown(1.25)
	

func processKeyPress(delta):
	var oldVelocity = speed
	var key = ''
	if Input.is_action_pressed("dKeyPress"):
		if 0 < speed and speed < 130:
			speed = 130
		scale.x = 1
		key = 'd'
		speed += acceleration * delta
		print("key = d")
		
	if Input.is_action_pressed("aKeyPress"):
		if -130 < speed and speed < 0:
			speed = -130
		scale.x = -1
		key = 'a'
		speed -= acceleration * delta
		print("key = a")
		
	speed = clamp(speed, -1 * MAX_VELOCITY, MAX_VELOCITY)
	
	return [oldVelocity != speed, key]

func slowDown(multiplier = 1):
	speed /= SLOWING_SPEED * multiplier
	if (-0.2 < speed && speed < 0.2):
		speed = 0
	print("slowDown")
