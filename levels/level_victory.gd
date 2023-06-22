extends Level

var victory_text: String = "I am the Sun-Shrine God! Thank you so much for defeating the storm dragon! \n You are a brave little Horus, perhaps oneday a Shrine will be built in your honor too!"

func _ready() -> void:
	MusicManager.battle.stop()
	MusicManager.rain.stop()
	MusicManager.ending.play()
	
	DialogueOverlay.show_text(DialogueOverlay.TEXT_POSITION.BOTTOM, false, victory_text)
