class_name State

extends Node

const ACCELERATION = 4000
const GRAVITY = 1000
const WALK_SPEED = 200
const JUMP_SPEED = -400


var player: Player


func _init(r: Player) -> void:
	player = r


func handle_input(_event: InputEvent) -> State:
	return null


func process_update(_delta: float) -> State:
	return null


func physics_update(_delta: float, _dir: Vector2) -> State:
	return null


func enter() -> void:
	pass

func exit() -> void:
	pass


func _calculate_horizontal_velocity(_delta: float, _dir: Vector2) -> void:
	if sign(_dir.x) != sign(player.velocity.x):
		player.velocity.x = 0.0
	
	player.velocity.x += _dir.x * ACCELERATION * _delta
	
	player.velocity.x = clamp(player.velocity.x, -WALK_SPEED, WALK_SPEED)

