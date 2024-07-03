extends Button


var testMap = "res://scenes/testMap.tscn"


func _process(delta):
	if button_pressed:
		get_tree().change_scene_to_file(testMap)
