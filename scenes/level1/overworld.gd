extends Node2D

func _ready() -> void:
	$YSort/NPC/CharacterBody2D/state_machine/move.curve = $Path2D.get_curve()
	#$Path2D.get_curve()
