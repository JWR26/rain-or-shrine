class_name Enemy

extends CharacterBody2D

enum STATE {
	IDLE,
	MOVE_TO,
	DEAD,
}

const GRAVITY = 360

var current_state: STATE = STATE.IDLE

@export var hp: int = 1


func hit(dmg: int = 1) -> void:
	hp -= dmg
	if hp == 0:
		die()


func die() -> void:
	pass
