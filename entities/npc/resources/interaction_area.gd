extends Area2D

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(other: Node) -> void:
	pass
