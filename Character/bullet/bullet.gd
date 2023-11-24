extends Area2D

@export var speed = 2000
var deviation : float = 0

func _ready():
	speed = GunStates.getCurrentGunStats()[2]
	deviation = GunStates.getCurrentGunStats()[5]
	deviation = (deviation * 0.001) * randf_range(-1, 1)
	
	
func _physics_process(delta):
	position += transform.x * speed * delta
	rotation += deviation

func _on_screen_exited():
	queue_free()

func _on_body_entered(_body):
	queue_free()

func _on_area_entered(area):
	print("Hit!")
	if area.is_in_group("enemies"):
		print("Hit! (Enemy)")
		area.queue_free()
