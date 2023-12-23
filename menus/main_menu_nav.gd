extends Control

enum MENU {
		NONE,
		MAIN,
		LOAD,
		OPTIONS,
		START
	}

var menus = {
	MENU.MAIN : "res://menus/main/MainMenu.tscn", 
	MENU.LOAD : "res://menus/main/LoadMenu.tscn",
	MENU.OPTIONS : "res://menus/main/OptionsMenu.tscn",
	MENU.START : "res://scenes/level1/Overworld.tscn"
}

@export var game_manager : GameManager

func _ready():
	SignalBus.connect("switch_menu", _on_switch_menu)
	SignalBus.connect("start_game", _start_game)

func _start_game(scene: String) -> void:
	game_manager.start_game(scene)

func _on_switch_menu(path: String) -> void:
	game_manager.load_menu(path)

