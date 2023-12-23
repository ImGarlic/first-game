extends Node
	
func get_movement_direction() -> Vector2:
	return Vector2(Input.get_vector('move_left', 'move_right', 'move_up', 'move_down'))
