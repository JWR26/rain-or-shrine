extends Level


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneChanger.change_scene($Portal.desitnation)
