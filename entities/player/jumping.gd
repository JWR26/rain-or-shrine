class_name Jumping

extends State

var can_double_jump: bool = true

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and can_double_jump:
		player.velocity.y = JUMP_SPEED
		can_double_jump = false
	return super.handle_input(_event)


func physics_update(_delta: float, _dir: Vector2) -> State:
	if player.is_on_floor() and player.velocity.y >= 0:
		return Moving.new(player)
	
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.1
	
	player.velocity.y += GRAVITY * _delta
	
	player.velocity.y = clamp(player.velocity.y, JUMP_SPEED, -JUMP_SPEED)
	
	_calculate_horizontal_velocity(_delta, _dir)
	
	return super.physics_update(_delta, _dir)



func enter() -> void:
	player.velocity.y = JUMP_SPEED


