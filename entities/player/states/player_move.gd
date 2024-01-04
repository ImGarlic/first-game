extends CharacterOverworldState

@export
var idle_state: CharacterOverworldState

func enter() -> void:
	var direction = get_movement()
	get_animation(direction)
	
func process_input(event: InputEvent) -> State:
	var direction = get_movement()
	if(get_movement() != Vector2.ZERO):
		get_animation(direction)
		
	#if(event.is_action_pressed("ui_accept") and parent.in_dialogue_area):
		#DialogueManager.show_example_dialogue_balloon(
			#load("res://entities/npc/character_first_fella/talk.dialogue")
		#)
		#return idle_state
	return null

func process_physics(_delta: float) -> State:
	var movement = get_movement() * move_speed
	
	if movement.x == 0 and movement.y == 0:
		return idle_state
	parent.velocity = movement
	parent.move_and_slide()
	
	return null
	
