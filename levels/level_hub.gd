extends Level



func _ready() -> void:
	update_portal_states()


func update_portal_states() -> void:
	$Portal1.completed = Globals.artifact_1_collected
	$Portal2.completed = Globals.artifact_2_collected
	$Portal3.completed = Globals.artifact_3_collected
	$Portal4.completed = Globals.artifact_4_collected
	$Artifact1.set_visible(Globals.artifact_1_collected)
	$Artifact2.set_visible(Globals.artifact_2_collected)
	$Artifact3.set_visible(Globals.artifact_3_collected)
	$Artifact4.set_visible(Globals.artifact_4_collected)
