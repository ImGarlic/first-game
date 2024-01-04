extends CharacterOverworldState

@export var move_state: CharacterOverworldState

func _ready() -> void:
	SignalBus.connect("dialogue_response", _dialogue_entered)
	
func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	
	animations.play(self.name + "_" + parent.direction)

func process_input(event: InputEvent) -> State:
	if(get_movement() != Vector2(0,0)):
		return move_state
		
	#if(event.is_action_pressed("ui_accept") and parent.in_dialogue_area):
		#DialogueManager.show_example_dialogue_balloon(
			#load("res://entities/npc/character_first_fella/talk.dialogue")
		#)
	return null

func process_physics(_delta):
	parent.move_and_slide()

	return null
	
func _dialogue_entered(position : Vector2) -> void:
	get_animation(parent.position.direction_to(position))
