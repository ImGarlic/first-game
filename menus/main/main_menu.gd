extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGame.grab_focus()

func _on_new_game_pressed():
	SignalBus.emit_signal("start_game", "level1/Overworld")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	SignalBus.emit_signal("switch_menu", "res://menus/main/LoadMenu.tscn")

func _on_options_pressed():
	SignalBus.emit_signal("switch_menu", "res://menus/main/OptionsMenu.tscn")

func _on_new_game_mouse_entered():
	$VBoxContainer/NewGame.grab_focus()

func _on_load_game_mouse_entered():
	$VBoxContainer/LoadGame.grab_focus()

func _on_options_mouse_entered():
	$VBoxContainer/Options.grab_focus()

func _on_quit_mouse_entered():
	$VBoxContainer/Quit.grab_focus()
