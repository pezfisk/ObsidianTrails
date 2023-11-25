extends Area2D

@export var speed = 2000
var deviation : float = 0
var power : int = 0

func _ready():
	speed = GLOBALS.bulletSpeed
	deviation = GLOBALS.bulletDeviation
	power = GLOBALS.bulletDamage
	deviation = (deviation * 0.001) * randf_range(-1, 1)

func _physics_process(delta):
	position += transform.x * speed * delta
	rotation += deviation

func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		print("Enemy hit!")
		body.takeDamage(power)
	else:
		print("Hit!")
	
	queue_free()
