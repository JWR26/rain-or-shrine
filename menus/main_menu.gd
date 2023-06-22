extends Control


@export var tutorial: String
@export var hub: String

@onready var play_button = $VSplitContainer/VBoxContainer/MarginContainer/Play



func _ready() -> void:
	Globals.reset_artifacts()
	play_button.grab_focus()


func _on_play_button_down() -> void:
	if Globals.tutorial_complete:
		SceneChanger.change_scene(hub)
	else:
		SceneChanger.change_scene(tutorial)


func _on_credits_meta_clicked(meta) -> void:
	OS.shell_open(meta)
