extends Level



func _ready() -> void:
	update_portal_states()
	if OS.is_debug_build():
		DebugOverlay.update_artifact_status()


func update_portal_states() -> void:
	$Portal1.completed = Globals.artifact_1_collected
	$Portal2.completed = Globals.artifact_2_collected
	$Portal3.completed = Globals.artifact_3_collected
	$Portal4.completed = Globals.artifact_4_collected
