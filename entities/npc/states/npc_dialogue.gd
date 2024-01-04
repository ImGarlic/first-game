extends CharacterOverworldState

@export var move_state: CharacterOverworldState
@export var idle_state: CharacterOverworldState

func _ready() -> void:
	SignalBus.connect("dialogue_triggered", _play_dialogue)

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	
	animations.play(self.name + "_" + parent.direction)

func exit() -> void:
	pass
	
func _play_dialogue() -> void:
	if(parent.player_in_range):
		DialogueManager.show_example_dialogue_balloon(
			load(parent.current_dialogue_path)
		)

