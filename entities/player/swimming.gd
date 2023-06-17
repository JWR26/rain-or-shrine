class_name Swimming

extends State

const FLOAT: float = -135.0
const FLOAT_RESISTANCE: float = 600.00
const SINK: float = 50.0
const SWIM: float = 75.0


func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = FLOAT
	return super.handle_input(_event)


func physics_update(_delta: float, _dir: Vector2) -> State:
	
	if player.velocity.y < 0:
		player.velocity.y += FLOAT_RESISTANCE * _delta
	else:
		player.velocity.y += SINK * _delta
	
	player.velocity.y = clamp(player.velocity.y, FLOAT, SINK)
	
	if sign(_dir.x) != sign(player.velocity.x):
		player.velocity.x = 0.0
	
	player.velocity.x += _dir.x * ACCELERATION * _delta
	
	player.velocity.x = clamp(player.velocity.x, -SWIM, SWIM)
	
	player.move_and_slide()
	
	return super.physics_update(_delta, _dir)

