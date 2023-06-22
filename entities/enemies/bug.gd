class_name Bug

extends CharacterBody2D

const SPEED: float = 50.0

var direction: Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	if not $Left.is_colliding():
		direction = Vector2.RIGHT
	if not $Right.is_colliding():
		direction = Vector2.LEFT
	
	velocity = SPEED * direction
	
	$Sprite2D.flip_h = true if direction.x > 0 else false
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	if not collision:
		return
	
	if collision.get_normal().x != 0:
		direction = Vector2.LEFT if direction.x > 0 else Vector2.RIGHT
