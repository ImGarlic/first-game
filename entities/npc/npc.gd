class_name NPC
extends CharacterBody2D

@export var resources : NPCResource

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $state_machine
@onready var move_component = $move_component
@onready var interaction_area = $InteractionArea
@onready var target_marker = $TargetMarker
@onready var timer = $state_machine/idle/Timer

var direction = "_DOWN"


func _ready():
	animations.frames = resources.sprite_frames
	state_machine.init(self, animations, move_component)
	interaction_area.connect("body_entered", _on_body_entered)
	interaction_area.connect("body_exited", _on_body_exited)
	
	timer.set_wait_time(resources.idle_time)
	timer.start()
	timer.paused = true
	
func _unhandled_key_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)

# Put NPC in idle state when a player character enters interaction area
func _on_body_entered(other: Node) -> void:
	if(other is Player):
		state_machine.change_state($state_machine/idle)
		target_marker.get_child(0).play_backwards("fade")
		$state_machine/idle/Timer.paused = true
		SignalBus.emit_signal("dialogue_area_entered", "res://entities/npc/character_first_fella/talk.dialogue")
	
# Put NPC in move state when a player character leaves interaction area
func _on_body_exited(other: Node) -> void:
	if(other is Player):
		state_machine.revert_state()
		target_marker.get_child(0).play("fade")
		SignalBus.emit_signal("dialogue_area_exited")

	
