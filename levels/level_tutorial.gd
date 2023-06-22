extends Level

@export var hub: String

@onready var text_box = $Instructions/VBox/Top

var tutorial_text: String = "Use the LEFT/RIGHT arrow keys to move.\nJump and double jump using Z\nCast using X"

var tutorial_text_2: String = "Hit SPACE to travel through the portals..."


func _ready() -> void:
	DialogueOverlay.show_text(DialogueOverlay.TEXT_POSITION.TOP, tutorial_text)
	DialogueOverlay.show_text(DialogueOverlay.TEXT_POSITION.BOTTOM, tutorial_text_2)


func _on_exit_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneChanger.change_scene(hub, 1.0)
		Globals.tutorial_complete = true
