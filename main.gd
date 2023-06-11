extends Control

@export var main_menu: PackedScene

func _ready() -> void:
	get_tree().change_scene_to_packed(main_menu)
