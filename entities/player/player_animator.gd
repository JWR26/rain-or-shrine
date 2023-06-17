extends AnimatedSprite2D

@export var p: Player


func change_direction(x_input: float = 0.0) -> void:
	if x_input < 0:
		flip_h = true
	elif x_input > 0:
		flip_h = false

func change_animation(to: State) -> void:
	if to is Idle:
		play("idle")
	elif to is Moving:
		play("walk")
	elif to is Jumping:
		play("jump")
	elif to is Falling:
		play("fall")


func cast_animation() -> void:
	play("cast")
	await self.animation_finished
	change_animation(p.current_state)
