class_name  Dragon

extends Enemy

const MAX_HP: int = 4

const TOP_CENTER = Vector2(427, 120)
const BOTTOM_RIGHT = Vector2(800, 344)
const BOTTOM_LEFT = Vector2(54, 344)

enum PHASE{
	IDLE,
	FIRE_DOWN,
	CHARGE,
	FIRE_SIDE,
	DEAD,
}

var current_phase: PHASE = PHASE.IDLE

var tween: Tween


func _ready() -> void:
	hp = MAX_HP
	set_health_bar()
	position = TOP_CENTER


func _physics_process(delta: float) -> void:
	if current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	
	
	move_and_slide()


func next_phase() -> void:
	


func set_health_bar() -> void:
	if not Globals.all_artifacts_collected():
		$CanvasLayer.hide()
	else:
		$AnimationPlayer.play("show_hp")
	
	$CanvasLayer/HP/Over.max_value = MAX_HP
	$CanvasLayer/HP/Over.value = MAX_HP
	$CanvasLayer/HP/Under.max_value = MAX_HP
	$CanvasLayer/HP/Under.value = MAX_HP


func hit(dmg: int = 1) -> void:
	$CanvasLayer/HP/Over.value = hp
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/HP/Under, "value", hp, 0.75).set_delay(1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	super.hit(dmg)


func die() -> void:
	print(hp)
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	velocity.y = -GRAVITY / 2
	$AnimationPlayer.play("hide_hp")
