class_name Fish

extends Enemy

enum DIR{
	RIGHT,
	LEFT,
}

const SWIM_SPEED: float = 25.0
const ATTACK_SPEED: float = 125.0

@export var start_direction: DIR

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	direction = Vector2.RIGHT if start_direction == DIR.RIGHT else Vector2.LEFT


func _physics_process(delta: float) -> void:
	if current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	else:
		var left = $PlayerSensorLeft.get_collider()
		var right = $PlayerSensorRight.get_collider()
		if (left is Player or right is Player) and current_state != STATE.ATTACK:
			current_state = STATE.ATTACK
			direction = Vector2.LEFT if left is Player else Vector2.RIGHT
		else:
			current_state = STATE.IDLE
		velocity = ATTACK_SPEED * direction if current_state == STATE.ATTACK else SWIM_SPEED * direction
	
	$AnimatedSprite2D.flip_h = true if direction.x > 0 else false
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision:
		direction = Vector2.LEFT if direction.x > 0 else Vector2.RIGHT


func _on_area_2d_body_entered(body: Node2D) -> void:
	if current_state == STATE.DEAD:
		return
	
	if body is Player:
		$PlayerSensorLeft.enabled = false
		$PlayerSensorRight.enabled = false
		$Cooldown.start(3.0)
		$AnimatedSprite2D.play("attack")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("swim")
	
	current_state = STATE.IDLE


func die() -> void:
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	velocity = Vector2(0, SWIM_SPEED)
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.flip_v = true


func _on_cooldown_timeout() -> void:
	$PlayerSensorLeft.enabled = true
	$PlayerSensorRight.enabled = true
