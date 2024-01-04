extends Area2D

# Manages the z index and collision layer of a body exiting the area.
# Mostly used for stairs
@export var upper_level_z_index : int
@export var upper_collision_layer : int
@export var lower_collision_layer : int
@export var upper_exit_side : ExitSide
@onready var collision_shape : CollisionShape2D = $CollisionShape2D

enum ExitSide {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}

func _on_body_exited(body : Node):
	if body is CharacterBody2D:
		var exit_side = _determine_exit_side(body)
		# Going up the stairs
		if(exit_side == upper_exit_side):
			body.set_z_index(upper_level_z_index)
			_set_collision_layer_and_mask(body, true)
		# Going down
		else:
			body.set_z_index(upper_level_z_index - 1)
			_set_collision_layer_and_mask(body, false)
		
func _set_collision_layer_and_mask(body : CharacterBody2D, going_up : bool) -> void:
	body.set_collision_layer_value(upper_collision_layer, going_up)
	body.set_collision_mask_value(upper_collision_layer, going_up)
	body.set_collision_layer_value(lower_collision_layer, !going_up)
	body.set_collision_mask_value(lower_collision_layer, !going_up)
	
	for child in body.get_children():
		if(child.has_method("set_collision_layer_value")):
			child.set_collision_layer_value(upper_collision_layer, going_up)
			child.set_collision_mask_value(upper_collision_layer, going_up)
			child.set_collision_layer_value(lower_collision_layer, !going_up)
			child.set_collision_mask_value(lower_collision_layer, !going_up)
	
func _determine_exit_side(body : CharacterBody2D):
	var relative_pos = body.global_position - collision_shape.global_position

	if abs(relative_pos.x) > abs(relative_pos.y):
		return ExitSide.RIGHT if relative_pos.x > 0 else ExitSide.LEFT
	else:
		return ExitSide.BOTTOM if relative_pos.y > 0  else ExitSide.TOP
	
