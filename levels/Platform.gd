class_name Platform

extends CharacterBody2D

const GRAVITY = 100

var active: bool = false

func _physics_process(delta: float) -> void:
	if active:
		velocity.y += GRAVITY * delta
		move_and_slide()


func set_active() -> void:
	await get_tree().create_timer(0.2).timeout
	active = true
