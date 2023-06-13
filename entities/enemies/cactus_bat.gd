class_name Enemy

extends CharacterBody2D

enum STATE {
	IDLE,
	MOVE_TO,
	DEAD,
}

const SPEED: float = 120
const GRAVITY = 360

var p: Player = null

var current_state: STATE = STATE.IDLE
var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if current_state == STATE.MOVE_TO:
		direction = global_position.direction_to(p.get_global_position())
		velocity = SPEED * direction
		$AnimatedSprite2D.flip_h = true if direction.x > 0 else false
	
	elif current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and current_state != STATE.DEAD:
		p = body
		current_state = STATE.MOVE_TO
		$AnimatedSprite2D.play("fly")


func die() -> void:
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	velocity.y = -SPEED
	$AnimatedSprite2D.play("die")
	$AnimatedSprite2D.rotate(PI)
