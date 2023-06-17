class_name Falling

extends State


func physics_update(_delta: float, _dir: Vector2) -> State:
	if player.is_on_floor():
		return Moving.new(player)
	
	player.velocity.y += GRAVITY * _delta
	
	player.velocity.y = clamp(player.velocity.y, JUMP_SPEED, -JUMP_SPEED)
	
	_calculate_horizontal_velocity(_delta, _dir)
	
	player.move_and_slide()
	
	return super.physics_update(_delta, _dir)


func enter() -> void:
	player.velocity = Vector2.ZERO
