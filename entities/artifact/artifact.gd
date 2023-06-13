class_name Artifact

extends Area2D


@export var number: int = -1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.artifact_collected(number)
		queue_free()
