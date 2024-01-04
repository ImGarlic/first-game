class_name Player
extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $state_machine
@onready var move_component = $move_component

var direction = "L"
var in_dialogue_area : bool

var tilemap : TileMap
var layers : int
var current_z_index = get_z_index()

func _ready():
	state_machine.init(self, animations, move_component)
	
func _unhandled_input(event: InputEvent) -> void:
	
	if(Input.is_action_just_pressed("ui_accept")):
		print("Z index: ", get_z_index())
		print("Collision layer 1: ", get_collision_layer_value(1))
		print("Collision layer 2: ", get_collision_layer_value(2))
		SignalBus.emit_signal("dialogue_request", position)
	state_machine.process_input(event)
	
func _physics_process(delta):
	Flags.player_position = position
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)
