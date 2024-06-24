extends Node2D

var speed = 5
var velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check for input
	if Input.is_action_pressed("dKeyPress"):
		position.x += speed * delta
	if Input.is_action_pressed("aKeyPress"):
		position.x -= speed * delta
	pass
