extends Node2D

func _ready() -> void:
	var main_menu_instance = load("res://scenes/battle/MainBattleMenu.tscn").instantiate()
	main_menu_instance.position = Vector2(576,324)
	add_child(main_menu_instance)
