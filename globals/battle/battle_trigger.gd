extends Area2D

func _ready() -> void:
	var pause = true

func _on_body_entered(body : Node):
	if(body is Player):
		SignalBus.emit_signal("battle_triggered")
		queue_free()

func _on_body_exited(body: Node):
	pass # Replace with function body.
	
#func set_pause_node(node : Node, pause : bool) -> void:
	#node.set_process(!pause)
	#node.set_process_input(!pause)
	#node.set_process_internal(!pause)
	#node.set_process_unhandled_input(!pause)
	#node.set_process_unhandled_key_input(!pause)
	
func pause() -> void:
	var parent = get_parent()
	parent.process_mode = Node.PROCESS_MODE_DISABLED
	
func unpause() -> void:
	var parent = get_parent()
	parent.process_mode = Node.PROCESS_MODE_INHERIT
