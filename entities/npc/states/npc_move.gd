extends CharacterOverworldState

@export var idle_state: CharacterOverworldState
@export var character : CharacterBody2D

var path
var path_follow
var curve
var next_waypoint = 1
	
func enter() -> void:
	path_follow = path.get_child(0)
	curve = path.get_curve()
	get_animation(path_follow.position.direction_to(curve.get_point_position(next_waypoint)))

func process_physics(delta: float) -> State:
	path_follow.progress += move_speed * delta
	
	if(path_follow.position.distance_to(curve.get_point_position(next_waypoint)) < 2):
		if(next_waypoint == curve.point_count - 1):
			next_waypoint = 1
		else:
			next_waypoint += 1
		return idle_state
		
	return null
