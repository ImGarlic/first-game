extends Node

@export
var starting_state : CharacterOverworldState

var current_state : CharacterOverworldState
var previous_state : CharacterOverworldState

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: CharacterBody2D, animations: AnimatedSprite2D, move_component) -> void:
	for child in get_children():
		child.parent = parent
		child.animations = animations
		if(move_component):
			child.move_component = move_component

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: CharacterOverworldState) -> void:
	if current_state:
		current_state.exit()

	previous_state = current_state
	current_state = new_state
	current_state.enter()
	
func revert_state() -> void:
	if current_state:
		current_state.exit()
	
	var temp = previous_state
	previous_state = current_state
	current_state = temp
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
