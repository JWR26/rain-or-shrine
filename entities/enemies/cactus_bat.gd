class_name CactusBat

extends Enemy

const SPEED: float = 120

var p: Player = null

var direction: Vector2 = Vector2.ZERO
var start_pos: Vector2

func _ready() -> void:
	start_pos = global_position


func _physics_process(delta: float) -> void:
	if current_state == STATE.MOVE_TO:
		direction = global_position.direction_to(p.get_global_position())
		velocity = SPEED * direction
		$AnimatedSprite2D.flip_h = true if direction.x > 0 else false
	
	elif current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			$Bite.play()
			collider.knock_back(global_position.x, 0.5)
			direction = global_position.direction_to(start_pos)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and current_state != STATE.DEAD:
		p = body
		current_state = STATE.MOVE_TO
		$AnimatedSprite2D.play("fly")


func die() -> void:
	$Death.play()
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	velocity.y = -SPEED
	$AnimatedSprite2D.play("die")
	$AnimatedSprite2D.rotate(PI)
