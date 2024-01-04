extends Node

class_name GameManager

@onready var menu : Control = $MainMenu
@onready var world : Node2D = $World
@onready var battle : Node2D = $Battle

var menu_instance : Control
var world_instance : Node2D
var battle_instance : Node2D
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		SignalBus.emit_signal("toggle_game_paused", game_paused)

func _ready() -> void:
	SignalBus.emit_signal("switch_menu", "res://menus/main/MainMenu.tscn")
	SignalBus.connect("battle_triggered", start_battle)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("pause") and menu_instance == null):
		game_paused = !game_paused

func start_game(scene: String) -> void:
	unload_menu()
	load_world(scene)

func return_to_menu() -> void:
	world_instance.queue_free()
	var menu_path = "res://menus/main/MainMenu.tscn"
	var scene = load(menu_path)
	if(scene):
		menu_instance = scene.instantiate()
		add_child(menu_instance)

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

func unload_world() -> void:
	if(is_instance_valid(world_instance)):
		world_instance.queue_free()
	world_instance = null

func load_world(world_name: String) -> void:
	unload_world()
	var scene_path = "res://scenes/%s.tscn"  % world_name
	var scene = load(scene_path)
	if(scene):
		world_instance = scene.instantiate()
		world.add_child(world_instance)

func unload_battle() -> void:
	if(is_instance_valid(battle_instance)):
		battle_instance.queue_free()
	battle_instance = null

func load_battle(battle_name: String) -> void:
	unload_world()
	var scene_path = "res://scenes/%s.tscn"  % battle_name
	var scene = load(scene_path)
	if(scene):
		battle_instance = scene.instantiate()
		battle.add_child(battle_instance)

func start_battle() -> void:
	call_deferred("pause_world")
	load_battle("battle/BattleScene")
	call_deferred("unpause_world")

func pause_world() -> void:
	world.process_mode = Node.PROCESS_MODE_DISABLED
	world.visible = false
	
func unpause_world() -> void:
	world.process_mode = Node.PROCESS_MODE_INHERIT
	world.visible = true
