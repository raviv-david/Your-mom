extends ColorRect

@export var parent : Node

enum locations {top_left, top_center, top_right,
				Center_left, center_center, center_right,
				bottom_left, bottom_center, bottom_right}

@export var relativeSize : int
@export var location : locations



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
