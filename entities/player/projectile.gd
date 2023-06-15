class_name Projectile

extends CharacterBody2D

const SPEED: float = 400.0

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = SPEED * direction
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision:
		var collider = collision.get_collider()
		if collider is Enemy:
			collider as Enemy
			collider.hit()
		
		queue_free()
