extends Level

@export var hub: String

@onready var text_box = $Instructions/VBox/Top


func _on_exit_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneChanger.change_scene(hub, 1.0)
		Globals.tutorial_complete = true
