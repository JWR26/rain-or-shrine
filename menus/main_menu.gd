extends Control


@export var level_0: PackedScene
@export var option_menu: PackedScene

@onready var play_button = $VSplitContainer/VBoxContainer/MarginContainer/Play
@onready var option_button = $VSplitContainer/VBoxContainer/MarginContainer2/Options
@onready var quit_button = $VSplitContainer/VBoxContainer/MarginContainer3/Quit


func _ready() -> void:
	play_button.grab_focus()


func _on_play_button_down() -> void:
	SceneChanger.change_scene(level_0)
