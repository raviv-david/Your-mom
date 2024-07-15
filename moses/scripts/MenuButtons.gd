extends Button


enum Actions {next_scene = 0, show_pannel = 1, hide_pannel = 2, quit = 3}

@export_file() var texture_path

@export var action : Actions

@export var show_on_click : Node = null
@export_file() var load_scene 

@export var slide_by = 40
@export var sliding_speed = 4

var STARTING_POS
var ENDING_POS

# Called when the node enters the scene tree for the first time.
func _ready():
	STARTING_POS = position.x
	ENDING_POS = STARTING_POS + slide_by
	if texture_path != null:
		$TextureRect.texture = load(texture_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button_pressed:
		match action:
			0:
				get_tree().change_scene_to_file(load_scene)
			1:
				show_on_click.visible = true
			2:
				show_on_click.visible = false
			3:
				get_tree().quit()
	if is_hovered():
		position.x = move_toward(position.x, ENDING_POS, sliding_speed)
	else:
		position.x = move_toward(position.x, STARTING_POS, sliding_speed)
		
