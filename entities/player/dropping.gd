class_name  Dropping

extends State


func physics_update(_delta: float, _dir: Vector2) -> State:
	if player.is_on_floor():
		return Moving.new(player)
	
	_calculate_horizontal_velocity(_delta, _dir)
	
	return super.physics_update(_delta, _dir)


func enter() -> void:
	
	if OS.is_debug_build():
		DebugOverlay.update_current_state("DROPPING")
