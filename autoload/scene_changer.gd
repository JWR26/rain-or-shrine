extends Control

var scene_change_in_progress: bool = false


func _input(event: InputEvent) -> void:
	# block user input while changing scene
	if scene_change_in_progress:
		accept_event()


func change_scene(to: PackedScene, delay: float = 1.0) -> void:
	scene_change_in_progress = true
	get_tree().change_scene_to_packed(to)
	scene_change_in_progress = false
