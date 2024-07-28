extends Area2D
class_name attack


@export var damage : int = 300


func _on_body_entered(player):
	var direction = Vector2()
	
	direction.x = player.position.x - self.position.x
	direction.x = clamp(direction.x, -1, 1)
	
	direction.y = player.position.y - self.position.y
	direction.y = clamp(direction.y, -1, 1)
	
	player.attack_recieved(damage, direction)
	self.queue_free()
