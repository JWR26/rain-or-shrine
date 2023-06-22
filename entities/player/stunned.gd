class_name Stunned

extends State

var direction: float = 0
var factor: float = 0
var in_water: bool = false

func _init(r: Player, d: float, f: float = 1, w: bool = false) -> void:
	direction = d
	player = r
	factor = f
	in_water = w


func physics_update(_delta: float, _dir: Vector2) -> State:
	if player.is_on_floor() and not player.velocity.y < 0:
		return Idle.new(player) if not in_water else Swimming.new(player)
	
	player.velocity.y += GRAVITY * _delta
	
	player.velocity.y = clamp(player.velocity.y, JUMP_SPEED, -JUMP_SPEED)
	
	player.move_and_slide()
	
	return super.physics_update(_delta, _dir)


func enter() -> void:
	player.velocity.x = direction * WALK_SPEED * factor
	player.velocity.y = JUMP_SPEED * factor
	
	print(player.velocity)
