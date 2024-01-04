extends Node2D

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var character : CharacterBody2D = $Path2D/PathFollow2D/CharacterBody2D
var last_position

func _ready() -> void:
	#$Path2D/PathFollow2D/CharacterBody2D
	last_position = $Path2D/PathFollow2D/CharacterBody2D.global_position
	character.path = path_follow

func _physics_process(delta: float) -> void:
	path_follow.progress += 100 * delta
	
	get_animation_for($Path2D/PathFollow2D/CharacterBody2D.global_position - last_position)
	
	last_position = $Path2D/PathFollow2D/CharacterBody2D.global_position

	
func get_animation_for(direction: Vector2):
	print(directions[int(round(direction.angle() / (PI / 4)))])
	print(direction)
	# moving left
	
	$Path2D/PathFollow2D/CharacterBody2D/AnimatedSprite2D.play("move_" + directions[int(round(direction.angle() / (PI / 4)))])
		
var directions = {
	2 : "DOWN",
	-2 : "UP",
	4 : "L",
	-4 : "L",
	3 : "L",
	-3 : "L",
	1 : "R",
	-1 : "R",
	0 : "R"
}
