extends CharacterOverworldState

@export var move_state: CharacterOverworldState
@onready var timer = $Timer

var wait = true

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
	parent.move_and_slide()
	
	return null
	
func _on_timer_timeout() -> void:
	timer.paused = true
	wait = false
