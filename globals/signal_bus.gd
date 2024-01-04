extends Node

signal on_freeze
signal start_game(scene_name : String)
signal toggle_game_paused(is_paused : bool)
signal switch_scene(scene_name : String)
signal switch_menu(menu_name : String)

# Dialogue request on playaer button press, response if valid entity in vicinity.
# Position is used to set facing direction
signal dialogue_request(position : Vector2)
signal dialogue_response(position : Vector2)
signal height_changed(z_index : int)

signal battle_triggered()
