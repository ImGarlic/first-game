extends CharacterOverworldState

@export
var idle_state: CharacterOverworldState

func enter() -> void:
	var direction = get_movement()
	get_animation(direction)

func process_physics(_delta: float) -> State:
	var direction = get_movement()
	var movement = direction * parent.resources.move_speed
	
	if(movement == Vector2(0,0)):
		return idle_state
		
#	_get_animation(direction)
	parent.velocity = movement
	parent.move_and_slide()
	
	return null
