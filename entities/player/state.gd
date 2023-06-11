class_name State

extends Node

const ACCELERATION = 400
const GRAVITY = 200
const WALK_SPEED = 120
const RUN_SPEED = 240
const JUMP_SPEED = -200


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
	if OS.is_debug_build():
		DebugOverlay.update_current_state("BASE STATE")


func exit() -> void:
	pass


func _calculate_horizontal_velocity(_delta: float, _dir: Vector2) -> void:
	if sign(_dir.x) != sign(player.velocity.x):
		player.velocity.x = 0.0
	
	player.velocity.x += _dir.x * ACCELERATION * _delta
	
	if Input.is_action_pressed("sprint"):
		player.velocity.x = clamp(player.velocity.x, -RUN_SPEED, RUN_SPEED)
	else:
		player.velocity.x = clamp(player.velocity.x, -WALK_SPEED, WALK_SPEED)

