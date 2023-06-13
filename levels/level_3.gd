extends Level


func _ready() -> void:
	$player/AnimatedSprite2D.flip_h = true


func _on_water_body_entered(body: Node2D) -> void:
	if body is Player:
		body.entered_water()


func _on_water_body_exited(body: Node2D) -> void:
	if body is Player:
		body.exited_water()
