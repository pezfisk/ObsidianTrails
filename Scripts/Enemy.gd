extends Node2D

@export var Bullet : PackedScene
@export var player : PackedScene

@onready var collision = $CollisionShape2D
@export var health = 100
@onready var shootTimer = $shootTimer
@onready var randomShootingDelay = $RandomShootingDelay

var shootDelayS : float = 0.1
var spread : float
var gunStats : Array = []
var gunSelection : Array
var a = 0
var pellets : int
var pelletC = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.disabled = true
	GunStates.selectGun("Rifle")
	gunSelection = GunStates.getData()
	@warning_ignore("unused_variable")
	var currentGun = GunStates.getGunStats("Rifle")
	shootDelayS = 1 #currentGun[0]
	pellets = 1 #currentGun[4]
	spread = 0 #currentGun[3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	look_at(GLOBALS.playerPos)
	randomShootingDelay.start(randi_range(1,5))
	
	#if !randomShootingDelay.is_stopped() && shootTimer.is_stopped():
		#@warning_ignore("shadowed_variable")
		#var pelletC = 0
		#while pelletC < pellets:
			#var b = Bullet.instantiate()
			#b.add_to_group("Bullets")
			#get_parent().add_child(b)
			#b.global_position = $Muzzle.global_position
			#@warning_ignore("narrowing_conversion")
			#b.global_rotation = $Muzzle.global_rotation + deg_to_rad(randi_range(-spread,spread))
			#b.scale.x = 0.255 / 2
			#b.scale.y = 0.045 / 2
			#shootTimer.start(shootDelayS)
			#pelletC += 1
			#randomShootingDelay.start(randi_range(1,5))

func takeDamage(power):
	health -= power
	if health <= 0:
		queue_free()

func _on_spawn_timer_timeout():
	collision.disabled = false
	$Area2D/CollisionShape2D.disabled = true

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body):
	if !$spawnTimer.is_stopped():
		position = Vector2(randi_range(50,8400),randi_range(50,5400))
		$spawnTimer.start()
