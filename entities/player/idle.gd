class_name Idle
## Idle state of the [player]

extends State


func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return Jumping.new(player)
	if Input.is_action_just_pressed("move_down"):
		return Dropping.new(player)
	
	return super.handle_input(_event)


func physics_update(_delta: float, _dir: Vector2) -> State:
	if not is_zero_approx(_dir.x) or not is_zero_approx(player.velocity.x):
		return Moving.new(player)
	
	if not player.is_on_floor():
		return Falling.new(player)
	
	return super.physics_update(_delta, _dir)


func enter() -> void:
	player.velocity = Vector2.ZERO
	if OS.is_debug_build():
		DebugOverlay.update_current_state("IDLE")
