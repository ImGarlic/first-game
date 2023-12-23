extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Back.grab_focus()
	
func _Input(event: InputEvent) -> void:
	if event.is_action_just_pressed('ui_cancel'):
			SignalBus.emit_signal("switch_menu", "res://menus/main/MainMenu.tscn")

func _on_back_pressed():
	SignalBus.emit_signal("switch_menu", "res://menus/main/MainMenu.tscn")
