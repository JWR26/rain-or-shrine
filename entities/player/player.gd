class_name Player
## Base class for the Player, the playable character of the game. A finite state machine.

extends CharacterBody2D

## The Player's current state. The Player will always start as [Idle]
var current_state: State = Idle.new(self)


func _unhandled_input(event) -> void:
	var _new_state: State = current_state.handle_input(event)
	if _new_state:
		change_state(_new_state)


func _process(delta) -> void:
	var _new_state: State = current_state.process_update(delta)
	if _new_state:
		change_state(_new_state)


func _physics_process(delta) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
	
	var _new_state: State = current_state.physics_update(delta, input_direction)
	if _new_state:
		change_state(_new_state)
	
	if OS.is_debug_build():
		DebugOverlay.update_player_velocity(velocity)
	
	move_and_slide()


## Handles the transition from one [State] to another. First, the [method State.exit] method of the [member current_state] is called and then freed from memory. 
func change_state(to: State) -> void:
	current_state.exit()
	current_state.free()
	current_state = to
	current_state.enter()
