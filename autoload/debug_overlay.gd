extends VBoxContainer

@onready var current_state = $CurrentState/State

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX


func update_current_state(state: String) -> void:
	current_state.set_text(state)


func update_player_velocity(value: Vector2) -> void:
	var s: String = "Velocity Y: {0}, X: {1}"
	$PlayerVelocity.set_text(s.format([value.y, value.x]))


func display_current_level(l: String) -> void:
	var s: String = "Currnt level: {0}"
	$CurrentLevel.set_text(s.format([l]))


func update_artifact_status() -> void:
	var s: String = "Artifact Collected 1: {0}, 2: {1}, 3: {2}, 4: {3}"
	$Artifacts.set_text(s.format(Globals.get_artifact_status()))
