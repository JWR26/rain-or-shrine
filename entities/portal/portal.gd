extends Area2D

@export var desitnation: String


var active: bool = false
var completed: bool = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_select") and active:
		SceneChanger.change_scene(desitnation)



func _on_body_entered(body: Node2D) -> void:
	if body is Player and not completed:
		active = true


func _on_body_exited(body: Node2D) -> void:
	active = false
