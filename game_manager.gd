extends Node

class_name GameManager

@onready var menu : Control = $MainMenu
@onready var world : Node2D = $World
var scene_instance : Node2D
var menu_instance : Control
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		SignalBus.emit_signal("toggle_game_paused", game_paused)
		
func _ready() -> void:
	SignalBus.emit_signal("switch_menu", "res://menus/main/MainMenu.tscn")
	pass
		
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("pause") and menu_instance == null):
		game_paused = !game_paused

func start_game(scene: String) -> void:
	unload_menu()
	load_scene(scene)
	
func return_to_menu() -> void:
	scene_instance.queue_free()
	var menu_path = "res://menus/main/MainMenu.tscn"
	var scene = load(menu_path)
	if(scene):
		menu_instance = scene.instantiate()
		add_child(menu_instance)

func unload_scene() -> void:
	if(is_instance_valid(scene_instance)):
		scene_instance.queue_free()
	scene_instance = null

func load_scene(scene_name: String) -> void:
	unload_scene()
	var scene_path = "res://scenes/%s.tscn"  % scene_name
	var scene = load(scene_path)
	if(scene):
		scene_instance = scene.instantiate()
		world.add_child(scene_instance)
		
		
func unload_menu() -> void:
	if(is_instance_valid(menu_instance)):
		menu_instance.queue_free()
	menu_instance = null

func load_menu(scene_path: String) -> void:
	unload_menu()
	var scene = load(scene_path)
	if(scene):
		menu_instance = scene.instantiate()
		add_child(menu_instance)
