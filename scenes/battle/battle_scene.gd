extends Node2D

func _ready() -> void:
	var fella = load("res://entities/battle/unit/BattleUnit.tscn").instantiate()
	var fella2 = load("res://entities/battle/unit/BattleUnit.tscn").instantiate()
	var fella3 = load("res://entities/battle/unit/BattleUnit.tscn").instantiate()
	var fella4 = load("res://entities/battle/unit/BattleUnit.tscn").instantiate()
	var fellas = [fella, fella2, fella3, fella4]
	
	var i = 0
	for pos in unit_positions[4]:
		fellas[i].position = pos
		fellas[i].get_child(0).play("attack")
		self.add_child(fellas[i])
		i += 1


var unit_positions = {
	1 : [Vector2(88,0)],
	2 : [Vector2(88,-24),Vector2(88,24)],
	3 : [Vector2(80,-40),Vector2(88,0),Vector2(80,40)],
	4 : [Vector2(88,-24),Vector2(80,-56),Vector2(80,56),Vector2(88,24)]
}

var enemy_positions = {
	
}
