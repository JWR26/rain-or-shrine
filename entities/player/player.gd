class_name Player
## Base class for the Player, the playable character of the game. A finite state machine.

extends CharacterBody2D

## The Player's current state. The Player will always start as [Idle]
var current_state: State = Idle.new(self)

@export var projectile: PackedScene

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

var hp: int = 3

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
		if collider is Bug:
			$BugImpact.play()
			knock_back(collider.global_position.x, 0.6)
		elif collider is Platform:
			collider.set_active()


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
	$CastSFX.play()
	$CastTimer.start(0.6)


func knock_back(dir: float, factor: float = 1, in_water: bool = false) -> void:
	$Hit.play()
	hp -= 1
	if hp < 1:
		$CollisionShape2D.disabled = true
		$CanvasLayer/Health.hide()
		MusicManager.battle.stop()
		SceneChanger.change_scene("res://levels/level_tutorial.tscn", 2.0)
	else:
		$CanvasLayer/Health.set_frame_and_progress(hp-1, 0.0)
	
	var d = clamp(global_position.x - dir, -1, 1)
	change_state(Stunned.new(self, d, factor, in_water))

func disable_collision() -> void:
	$CollisionShape2D.disabled = true
