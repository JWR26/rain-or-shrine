class_name Artifact

extends Area2D


var a1 = preload("res://assets/Artifact01.png")
var a2 = preload("res://assets/Artifact02.png")
var a3 = preload("res://assets/Artifact03.png")
var a4 = preload("res://assets/Artifact04.png")


@export var number: int = -1


func _ready() -> void:
	match number:
		0:
			$Sprite2D.set_texture(a1)
		1:
			$Sprite2D.set_texture(a2)
		2:
			$Sprite2D.set_texture(a3)
		3:
			$Sprite2D.set_texture(a3)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.artifact_collected(number)
		queue_free()
