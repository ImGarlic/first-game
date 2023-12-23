extends Node

@export
var parent: CharacterBody2D

var target_list : Array
var i : int = 0
var target : Vector2

func _ready() -> void:
	target_list = parent.resources.path_coordinates
	target = target_list[i]
	
# Follow points set by parent target_list
func get_movement_direction() -> Vector2:
	var position = parent.position
	target = target_list[i]
	
	if(position.distance_to(target) < 2):
		if(i == target_list.size() - 1):
			i = 0
			return Vector2(0,0)
		else:
			i += 1
			return Vector2(0,0)
	
	return parent.position.direction_to(target)

