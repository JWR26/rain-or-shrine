class_name  Dragon

extends Enemy

const SPEED: float = 149.2
const CHARGE_SPEED: float = 447.6

const TOP_CENTER = Vector2(427, 152)
const BOTTOM_RIGHT = Vector2(800, 340)
const LEFT = 54
const RIGHT = 800

enum PHASE{
	IDLE,
	FIRE_DOWN,
	FIRE_SIDE,
	CHARGE,
	DEAD,
}

var current_phase: PHASE = PHASE.IDLE

var tween: Tween

@export var player: Node
@export var projectile: PackedScene

func _ready() -> void:
	position = TOP_CENTER
	await get_tree().create_timer(3.0).timeout
	next_phase()
	set_health_bar()
	


func _physics_process(delta: float) -> void:
	if current_phase == PHASE.IDLE:
		return
	
	if current_state == STATE.DEAD:
		velocity.y += GRAVITY * delta
	
	elif current_phase == PHASE.FIRE_DOWN:
		if position.x < LEFT:
			velocity.x = SPEED
		elif position.x > RIGHT:
			velocity.x = -SPEED
		elif velocity == Vector2.ZERO:
			velocity.x = SPEED
		else:
			pass
	
	elif current_phase == PHASE.CHARGE:
		velocity.x = -CHARGE_SPEED
		if position.x < LEFT:
			velocity = Vector2.ZERO
			next_phase()
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			collider.knock_back(global_position.x)
			next_phase()



func next_phase() -> void:
	if current_state == STATE.DEAD:
		return
	
	if current_phase == PHASE.IDLE and Globals.all_artifacts_collected():
		current_phase = PHASE.FIRE_DOWN
		$PhaseTimer.start(10.0)
	elif current_phase == PHASE.FIRE_DOWN:
		velocity = Vector2.ZERO
		current_phase = PHASE.FIRE_SIDE
		var phase_tween = get_tree().create_tween()
		phase_tween.tween_property(self, "position", BOTTOM_RIGHT, 2.0).set_trans(Tween.TRANS_CUBIC).set_delay(0.5)
		$PhaseTimer.start(4.0)
	elif current_phase == PHASE.FIRE_SIDE:
		velocity = Vector2.ZERO
		current_phase = PHASE.CHARGE
		$Roar.play()
	elif current_phase == PHASE.CHARGE:
		velocity = Vector2.ZERO
		current_phase = PHASE.IDLE
		var phase_tween = get_tree().create_tween()
		phase_tween.tween_property(self, "position", TOP_CENTER, 2.0).set_trans(Tween.TRANS_CUBIC).set_delay(1.5)
		$PhaseTimer.start(4.0)


func set_health_bar() -> void:
	if not Globals.all_artifacts_collected():
		$CanvasLayer.hide()
	else:
		$AnimationPlayer.play("show_hp")
	
	$CanvasLayer/HP/Over.max_value = hp
	$CanvasLayer/HP/Over.value = hp
	$CanvasLayer/HP/Under.max_value = hp
	$CanvasLayer/HP/Under.value = hp


func hit(dmg: int = 1) -> void:
	$CanvasLayer/HP/Over.value = hp
	$Hit.play()
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/HP/Under, "value", hp, 0.75).set_delay(1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	super.hit(dmg)


func die() -> void:
	$Roar.play()
	if tween:
		tween.stop()
	current_phase == PHASE.IDLE
	$CollisionShape2D.disabled = true
	current_state = STATE.DEAD
	$AnimationPlayer.play("hide_hp")
	var t: Tween = get_tree().create_tween()
	t.tween_property($Sprite2D, "rotation", PI, 0.75).set_delay(0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	SceneChanger.change_scene("res://levels/level_victory.tscn", 3.0)


func _on_phase_timer_timeout() -> void:
	next_phase()


func fire_projectile() -> void:
	var dir = global_position.direction_to(player.get_global_position())
	var p = projectile.instantiate()
	p.add_collision_exception_with(self)
	$ProjectileContainer.add_child(p)
	$CastSFX.play()
	p.set_global_position(global_position)
	p.direction = dir
	


func _on_cast_timer_timeout() -> void:
	if current_phase == PHASE.FIRE_DOWN:
		fire_projectile()
