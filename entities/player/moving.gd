class_name  Moving

extends State


func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return Jumping.new(player)
	return super.handle_input(_event)


func physics_update(_delta: float, _dir: Vector2) -> State:
	if is_zero_approx(_dir.x):
		return Idle.new(player)
	
	if not player.is_on_floor():
		return Falling.new(player)
	
	_calculate_horizontal_velocity(_delta, _dir)
	
	return super.physics_update(_delta, _dir)


