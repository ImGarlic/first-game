class_name CharacterOverworldState
extends State

@export var animation_name: String
@export var move_speed: int

var animations: AnimatedSprite2D
var parent: CharacterBody2D
var move_component

func enter() -> void:
	pass
	
func get_movement() -> Vector2:
	return move_component.get_movement_direction()

#Fancy radians math to map directions in 8 ways
func get_animation(direction: Vector2) -> void:
	parent.direction = directions[int(round(direction.angle() / (PI / 4)))]
	
	animations.play(self.name + "_" + parent.direction)
	
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
