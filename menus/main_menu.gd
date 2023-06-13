extends Control


@export var tutorial: String
@export var hub: String
@export var option_menu: String

@onready var play_button = $VSplitContainer/VBoxContainer/MarginContainer/Play
@onready var option_button = $VSplitContainer/VBoxContainer/MarginContainer2/Options
@onready var quit_button = $VSplitContainer/VBoxContainer/MarginContainer3/Quit


func _ready() -> void:
	Globals.reset_artifacts()
	play_button.grab_focus()


func _on_play_button_down() -> void:
	if Globals.tutorial_complete:
		SceneChanger.change_scene(hub)
	else:
		SceneChanger.change_scene(tutorial)




func _on_quit_button_down() -> void:
	get_tree().quit()
