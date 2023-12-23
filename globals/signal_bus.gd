extends Node

signal on_freeze
signal start_game(scene_name : String)
signal toggle_game_paused(is_paused : bool)
signal switch_scene(scene_name : String)
signal switch_menu(menu_name : String)
signal dialogue_area_entered(dialogue_path : String)
signal dialogue_area_exited
