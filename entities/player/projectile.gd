class_name Projectile

extends CharacterBody2D

@export var fx: PackedScene
@export var SPEED: float = 400.0

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = SPEED * direction
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision:
		var collider = collision.get_collider()
		if collider is Enemy:
			collider.hit()
		elif collider is Player:
			collider.knock_back(global_position.x, 0.25)
		
		
		var f = fx.instantiate()
		get_parent().add_child(f)
		f.set_global_position(global_position)
		queue_free()
