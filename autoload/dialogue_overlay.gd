extends CanvasLayer


enum TEXT_POSITION{
	TOP,
	MIDDLE,
	BOTTOM,
}

@onready var top: Label = $VBox/Top
@onready var mid: Label = $VBox/Middle
@onready var bottom: Label = $VBox/Bottom


func show_text(pos: TEXT_POSITION, text: String) -> void:
	var label: Label
	
	if pos == TEXT_POSITION.TOP:
		label = top
	elif pos == TEXT_POSITION.MIDDLE:
		label = mid
	elif  pos == TEXT_POSITION.BOTTOM:
		label = bottom
	
	label.set_text(text)


func clear() -> void:
	top.text = ""
	mid.text = ""
	bottom.text = ""
	get_tree().paused = false
