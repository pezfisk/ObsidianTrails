extends Node2D

@export var Enemy : PackedScene
@export var numberEnemies : int
@export var point1 : Node2D
@export var point2 : Node2D
var i = 0

# Called when the node enters the scene tree for the first time.
func _process(_delta):
	while i <= numberEnemies:
		i += 1
		var e = Enemy.instantiate()
		e.add_to_group("enemy")
		get_parent().add_child(e)
		#e.global_position = Vector2(randi_range(400,200),randi_range(50,600))
		#print((Vector2(point1.global_position.x,point1.global_position.y)))
		#print((Vector2(point2.global_position.x,point2.global_position.y)))
		@warning_ignore("narrowing_conversion")
		e.global_position = Vector2(randi_range(point1.global_position.x,point2.global_position.x),randi_range(point1.global_position.y,point2.global_position.y))
