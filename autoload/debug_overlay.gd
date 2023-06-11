extends VBoxContainer

@onready var current_state = $CurrentState/State

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX


func update_current_state(state: String) -> void:
	current_state.set_text(state)

func update_player_velocity(value: Vector2) -> void:
	var s: String = "Robot Velocity\n   Y: {0} \n   X: {1}"
	$RobotVelocity.set_text(s.format([value.y, value.x]))


func display_current_level(str: String) -> void:
	$Label.set_text(str)
