extends Control

var scene_change_in_progress: bool = false


func _input(_event: InputEvent) -> void:
	# block user input while changing scene
	if scene_change_in_progress:
		accept_event()


func change_scene(to: String, delay: float = 1.0) -> void:
	scene_change_in_progress = true
	get_tree().change_scene_to_file(to)
	scene_change_in_progress = false
