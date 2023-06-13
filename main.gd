extends Control

@export var main_menu: String

func _ready() -> void:
	SceneChanger.change_scene(main_menu)
