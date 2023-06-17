class_name Player
## Base class for the Player, the playable character of the game. A finite state machine.

extends CharacterBody2D

## The Player's current state. The Player will always start as [Idle]
var current_state: State = Idle.new(self)

@export var projectile: PackedScene

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D


func _unhandled_input(event) -> void:
	if Input.is_action_just_pressed("cast") and $CastTimer.is_stopped():
		cast()
		return
	
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
	
	animator.change_direction(input_direction.x)
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		var above: bool = true if collider.get_position().y > position.y + 8 else false
		if collider is CactusBat and above:
			collider.die()
			velocity.y = State.JUMP_SPEED / 2.0


## Handles the transition from one [State] to another. First, the [method State.exit] method of the [member current_state] is called and then freed from memory. 
func change_state(to: State) -> void:
	current_state.exit()
	current_state.free()
	current_state = to
	current_state.enter()
	animator.change_animation(to)


func entered_water() -> void:
	change_state(Swimming.new(self))


func exited_water() -> void:
	var new_state = Jumping.new(self)
	new_state.can_double_jump = false
	change_state(new_state)


func cast() -> void:
	var dir = Vector2.LEFT if $AnimatedSprite2D.flip_h else Vector2.RIGHT
	var p = projectile.instantiate()
	animator.cast_animation()
	p.add_collision_exception_with(self)
	$ProjectileContainer.add_child(p)
	p.set_global_position(global_position + Vector2(24, -8))
	p.direction = dir
	$CastTimer.start(0.6)


func knock_back(dir: Vector2) -> void:
	change_state(Stunned.new(self))
