extends Control

@onready var resume_button = $VSplitContainer/VBoxContainer/MarginContainer/Resume
@onready var option_button = $VSplitContainer/VBoxContainer/MarginContainer2/Options
@onready var quit_button = $VSplitContainer/VBoxContainer/MarginContainer3/Quit

var active: bool = false


func _ready() -> void:
	resume_button.grab_focus()


func _input(event: InputEvent) -> void:
	# inactive pause menu should not consume input events
	if not active:
		pass


func display() -> void:
	active = true
	get_tree().paused = true
	show()


func _on_resume_button_down() -> void:
	active = false
	get_tree().paused = false
	hide()
