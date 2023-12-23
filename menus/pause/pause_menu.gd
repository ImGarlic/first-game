extends Control


@export var game_manager : GameManager

func _ready() -> void:
	SignalBus.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)
	hide()
#	SignalBus.toggle_game_paused.connect(_on_game_manager_toggle_game_paused)
	
func _on_game_manager_toggle_game_paused(is_paused: bool) -> void:
	if(is_paused):
		show()
	else:
		hide()

func _on_continue_mouse_entered() -> void:
	$Panel/VBoxContainer2/Continue.grab_focus()

func _on_main_menu_mouse_entered() -> void:
	$Panel/VBoxContainer2/MainMenu.grab_focus()

func _on_continue_pressed() -> void:
	game_manager.game_paused = false

func _on_main_menu_pressed() -> void:
	game_manager.return_to_menu()
	game_manager.game_paused = false
