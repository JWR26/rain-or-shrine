class_name Level

extends Node

@export var level_name: String

func _ready() -> void:
	if OS.is_debug_build():
		DebugOverlay.display_current_level(level_name)
		DebugOverlay.update_artifact_status()

