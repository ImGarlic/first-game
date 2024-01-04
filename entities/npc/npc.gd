class_name NPC
extends CharacterBody2D

@export var resources : NPCResource

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $state_machine
@onready var interaction_area = $InteractionArea
@onready var target_marker = $TargetMarker
@onready var timer = $state_machine/idle/Timer
@export var path : Path2D

var direction : String = "DOWN"
var player_in_range : bool = false
var current_dialogue_path: String = "res://entities/npc/character_first_fella/talk.dialogue"
var prev_z


func _ready():
	$state_machine/move.path = path
	$state_machine/move.move_speed = resources.move_speed
	animations.frames = resources.sprite_frames
	state_machine.init(self, animations, null)
	
	timer.set_wait_time(resources.idle_time)
	timer.start()
	
func _unhandled_key_input(event):
	if(Input.is_action_just_pressed("ui_accept")):
		print("Z index: ", get_z_index())
		print("Collision layer 1: ", get_collision_layer_value(1))
		print("Collision layer 2: ", get_collision_layer_value(2))
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)

# Put NPC in idle state when a player character enters interaction area
func _on_interaction_area_body_entered(other : Node):
	if(other is Player):
		state_machine.change_state($state_machine/idle)
		target_marker.get_child(0).play_backwards("fade")
		player_in_range = true
		prev_z = get_z_index()
		set_z_index(other.get_z_index())
		timer.paused = true

# Put NPC in move state when a player character leaves interaction area
func _on_interaction_area_body_exited(other : Node):
	if(other is Player):
		state_machine.revert_state()
		target_marker.get_child(0).play("fade")
		player_in_range = false
		set_z_index(prev_z)
