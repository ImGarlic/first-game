extends CharacterOverworldState

@export var move_state: CharacterOverworldState
@onready var timer = $Timer

var wait = true

func _ready() -> void:
	SignalBus.connect("dialogue_request", _play_dialogue)

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	
	wait = true
	timer.paused = false
	
	animations.play(self.name + "_" + parent.direction)

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	
	if(!wait):
		return move_state
	
	return null
	
func _on_timer_timeout() -> void:
	timer.paused = true
	wait = false
	
func _play_dialogue(position : Vector2) -> void:
	if(position != null and parent.player_in_range):
		SignalBus.emit_signal("dialogue_response", parent.position)
		_look_at_entity(position)
		
		DialogueManager.show_example_dialogue_balloon(
			load(parent.current_dialogue_path)
		)
		
func _look_at_entity(position : Vector2) -> void:
	get_animation(parent.position.direction_to(position))
