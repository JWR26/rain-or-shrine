class_name Fish

extends Enemy

enum DIR{
	RIGHT,
	LEFT,
}

const SWIM_SPEED: float = 50.0

@export var start_direction: DIR

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	direction = Vector2.RIGHT if start_direction == DIR.RIGHT else Vector2.LEFT


func _physics_process(delta: float) -> void:
	if current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	else:
		velocity = SWIM_SPEED * direction
	
	$AnimatedSprite2D.flip_h = true if direction.x > 0 else false
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision:
		direction = Vector2.LEFT if direction.x > 0 else Vector2.RIGHT


func _on_area_2d_body_entered(body: Node2D) -> void:
	if current_state == STATE.DEAD:
		return
	
	if body is Player:
		$Bite.play()
		direction.x = position.direction_to(body.global_position).x
		$AnimatedSprite2D.play("attack")
		await $AnimatedSprite2D.animation_finished
		body.knock_back(global_position.x, 0.5, true)
		$AnimatedSprite2D.play("swim")

func die() -> void:
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	velocity = Vector2(0, SWIM_SPEED)
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.flip_v = true

