class_name Jumping

extends State


func physics_update(_delta: float, _dir: Vector2) -> State:
	if player.is_on_floor() and player.velocity.y >= 0:
		return Moving.new(player)
	
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.1
	
	player.velocity.y += GRAVITY * _delta
	
	_calculate_horizontal_velocity(_delta, _dir)
	
	return super.physics_update(_delta, _dir)



func enter() -> void:
	player.velocity.y = JUMP_SPEED
	if OS.is_debug_build():
		DebugOverlay.update_current_state("JUMPING")


