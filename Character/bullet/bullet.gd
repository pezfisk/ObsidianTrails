extends Area2D

@export var speed = 2000
var deviation : float = 0
var power : int = 0
var hit : bool = false
var sine : float = 0

@onready var sprite = $Sprite2D
@onready var particles = $GPUParticles2D
@onready var deSpawn = $deSpawnTimer

func _ready():
	speed = GLOBALS.bulletSpeed
	deviation = GLOBALS.bulletDeviation
	power = GLOBALS.bulletDamage
	deviation = (deviation * 0.001) * randf_range(-1, 1)

func _physics_process(delta):
	if !hit:
		position += transform.x * speed * delta
		rotation += deviation

func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	hit = true
	if body.is_in_group("enemy"):
		body.takeDamage(power)
		
	sprite.visible = false
	position += transform.x * 2
	deSpawn.start(1)

func _on_de_spawn_timer_timeout():
	queue_free()
