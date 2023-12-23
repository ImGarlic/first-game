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
	SignalBus.connect("dialogue_area_entered", _dialogue_area_entered)
	SignalBus.connect("dialogue_area_exited", _dialogue_area_exited)
	state_machine.init(self, animations, move_component)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	_get_elevation_index()
	
func _process(delta):
	state_machine.process_frame(delta)
	
func _dialogue_area_entered(dialogue_path: String) -> void:
	in_dialogue_area = true
	
func _dialogue_area_exited() -> void:
	in_dialogue_area = false
	
func _get_elevation_index() -> void:
	for child in get_parent().get_children():
		if(child is TileMap):
			tilemap = child
			break
			
	layers = tilemap.get_layers_count()
	var tile_under : Vector2i = tilemap.local_to_map(position)
	
	for layer in layers:
		var tile_data = tilemap.get_cell_tile_data(layer, tile_under)
		
		if(tile_data and tile_data.get_custom_data("stair")):
			set_z_index(round(tile_data.get_custom_data("stair")))
			set_collision_layer_value(elevation_index[get_z_index()], true)
			set_collision_mask_value(elevation_index[get_z_index()], true)
			print(current_z_index, get_z_index())
			set_collision_layer_value(elevation_index[current_z_index], false)
			set_collision_mask_value(elevation_index[current_z_index], false)
		else:
			var current_z_index = get_z_index()
		
	
	
var elevation_index = {
	0 : 1,
	1 : 8
}
