extends Level

var help_text: String = "Little Horus, please help a weak old dragon! the strom blew away my artifacts and now I might die! \n be a kind little horus and travel through the portals to get them for me..."

var battle_text: String = "NOW I HAVE ALL THE ARTIFACTS!\n NOW I HAVE ALL THE POWER !!\n NOW YOU WILL BE DEFEATED LITTLE HORUS !!!"

func _ready() -> void:
	update_portal_states()
	if Globals.all_artifacts_collected():
		MusicManager.battle.play()
		DialogueOverlay.show_text(DialogueOverlay.TEXT_POSITION.BOTTOM, battle_text)
		await  get_tree().create_timer(5.0).timeout
		DialogueOverlay.clear()
	else:
		DialogueOverlay.show_text(DialogueOverlay.TEXT_POSITION.BOTTOM, help_text)
		await  get_tree().create_timer(5.0).timeout
		DialogueOverlay.clear()


func update_portal_states() -> void:
	$Portal1.completed = Globals.artifact_1_collected
	$Portal2.completed = Globals.artifact_2_collected
	$Portal3.completed = Globals.artifact_3_collected
	$Portal4.completed = Globals.artifact_4_collected
	$Artifact1.set_visible(Globals.artifact_1_collected)
	$Artifact2.set_visible(Globals.artifact_2_collected)
	$Artifact3.set_visible(Globals.artifact_3_collected)
	$Artifact4.set_visible(Globals.artifact_4_collected)
	$Restoredpedestal.set_visible(Globals.artifact_1_collected)
	$Restoredpedestal2.set_visible(Globals.artifact_2_collected)
	$Restoredpedestal3.set_visible(Globals.artifact_3_collected)
	$Restoredpedestal4.set_visible(Globals.artifact_4_collected)
	$Destroyedpedestal.set_visible(!Globals.artifact_1_collected)
	$Destroyedpedestal2.set_visible(!Globals.artifact_2_collected)
	$Destroyedpedestal3.set_visible(!Globals.artifact_3_collected)
	$Destroyedpedestal4.set_visible(!Globals.artifact_4_collected)
	$PortalSprite.set_visible(!Globals.artifact_1_collected)
	$PortalSprite2.set_visible(!Globals.artifact_2_collected)
	$PortalSprite3.set_visible(!Globals.artifact_3_collected)
	$PortalSprite4.set_visible(!Globals.artifact_4_collected)


func _on_portal_1_body_entered(body: Node2D) -> void:
	if not Globals.all_artifacts_collected():
		print("dialogue")
