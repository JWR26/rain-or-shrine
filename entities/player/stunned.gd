class_name Stunned

extends State


func physics_update(_delta: float, _dir: Vector2) -> State:
	player.velocity.y += GRAVITY * _delta
	
	player.velocity.y = clamp(player.velocity.y, JUMP_SPEED, -JUMP_SPEED)
	
	player.move_and_slide()
	
	return super.physics_update(_delta, _dir)
