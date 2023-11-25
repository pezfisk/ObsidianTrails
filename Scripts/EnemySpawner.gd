extends Node2D

@export var Enemy : PackedScene
@export var numberEnemies : int
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while i <= numberEnemies:
		print(i)
		i += 1
		var e = Enemy.instantiate()
		e.add_to_group("enemy")
		get_parent().add_child(e)
		e.global_position = Vector2(randi_range(50,8400),randi_range(50,5400))
