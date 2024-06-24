extends RigidBody2D

var MAX_VELOCITY = 3

var speed = 5
var velocity = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	# processes player movement input
	var keyPressed = processKeyPress(delta)
	
	# slows the player down if hes not trying to move
	if (!keyPressed[0]):
		slowDown()
	print("v = ", velocity)
	position.x += velocity
	# causes the player to slow down quicker if he's pressing the button opposite to the current movement
	if (keyPressed[0]):
		if (keyPressed[1] == 'd' && velocity < -0.1):
			slowDown()
		print("v = ", velocity)
		if (keyPressed[1] == 'a' && velocity > 0.1):
			slowDown()

func processKeyPress(delta):
	var oldVelocity = velocity
	var key = ''
	if Input.is_action_pressed("dKeyPress"):
		scale.x = 1
		key = 'd'
		if velocity < MAX_VELOCITY:
			velocity += speed * delta
			print("key = d")
	if Input.is_action_pressed("aKeyPress"):
		scale.x = -1
		key = 'a'
		if velocity > MAX_VELOCITY * -1:
			velocity -= speed * delta
			print("key = a")
	return [oldVelocity != velocity, key]

func slowDown():
	velocity /= 1.065
	if (-0.2 < velocity && velocity < 0.2):
		velocity = 0
	print("slowDown")
