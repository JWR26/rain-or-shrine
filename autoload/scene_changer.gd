extends Control

var scene_change_in_progress: bool = false


func _input(_event: InputEvent) -> void:
	# block user input while changing scene
	if scene_change_in_progress:
		accept_event()
		


func change_scene(to: String, delay: float = 0.25) -> void:
	scene_change_in_progress = true
	DialogueOverlay.clear()
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(to)
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play_backwards("fade")
	scene_change_in_progress = false
