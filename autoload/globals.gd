extends Node


var artifact_1_collected: bool = true
var artifact_2_collected: bool = true
var artifact_3_collected: bool = true
var artifact_4_collected: bool = true

var tutorial_complete: bool = false


func all_artifacts_collected() -> bool:
	return artifact_1_collected and artifact_2_collected and artifact_3_collected and artifact_4_collected


func get_artifact_status() -> Array:
	return [artifact_1_collected,
	artifact_2_collected,
	artifact_3_collected,
	artifact_4_collected
	]


func artifact_collected(i: int) -> void:
	match i:
		0:
			artifact_1_collected = true
		1:
			artifact_2_collected = true
		2:
			artifact_3_collected = true
		3:
			artifact_4_collected = true


func reset_artifacts() -> void:
	artifact_1_collected = false
	artifact_2_collected = false
	artifact_3_collected = false
	artifact_4_collected = false
