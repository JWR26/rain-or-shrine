class_name Fish

extends CharacterBody2D

enum DIR{
	RIGHT,
	LEFT,
}

const SWIM_SPEED: float = 50.0
const ATTACK_SPEED: float = 100.0

@export var start_direction: DIR

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	direction = Vector2.RIGHT if start_direction == DIR.RIGHT else Vector2.LEFT


func _physics_process(delta: float) -> void:
	velocity = SWIM_SPEED * direction
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
	else:
		direction.x *= -1;
