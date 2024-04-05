extends CharacterBody2D

@export var speed = 250
@export var friction = 0.25
@export var acceleration = 0.5
@export var ogZoom = 1

@export var Bullet : PackedScene

@onready var shootTimer = $shootTimerDelay
@onready var spawnTimer = $spawnTimer
@onready var camera = $Camera2D
@onready var Area2d = $Area2D
var badSpawn = false

# GUN LOGIC
var shootDelayS : float = 0.1
var spread : float
var gunStats : Array = []
var gunSelection : Array
var a = 0
var pellets : int
var pelletC = 0
var knockback : float = 0

func _ready():
	gunSelection = GunStates.getData()
	gunStats = GunStates.getCurrentGunStats()
	shootDelayS = gunStats[0]
	GLOBALS.bulletDamage = gunStats[1]
	GLOBALS.bulletSpeed = gunStats[2]
	spread = gunStats[3]
	pellets = gunStats[4]
	GLOBALS.bulletDeviation = gunStats[5]
	knockback = gunStats[6]
	print(gunSelection)

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += Input.get_action_strength("right")
	if Input.is_action_pressed('left'):
		input.x -= Input.get_action_strength("left")
	if Input.is_action_pressed('down'):
		input.y += Input.get_action_strength("down")
	if Input.is_action_pressed('up'):
		input.y -= Input.get_action_strength("up")
	#if Input.is_anything_pressed() == false:
		#camera.zoom = Vector2(1,1)
		
	return input

func _physics_process(_delta):
	GLOBALS.playerPos = position
	
	var direction = get_input()
	if direction.length() > 0:
		if GLOBALS.isMobileOrController:
			velocity = direction * speed
		else:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2(0,0), friction)

	if Input.is_action_pressed("shoot") && shootTimer.is_stopped():
		@warning_ignore("shadowed_variable")
		var pelletC = 0
		add_force(knockback)
		while pelletC < pellets:
			var b = Bullet.instantiate()
			b.add_to_group("Bullets")
			get_parent().add_child(b)
			b.global_position = $Muzzle.global_position
			@warning_ignore("narrowing_conversion")
			b.global_rotation = $Muzzle.global_rotation + deg_to_rad(randi_range(-spread,spread))
			#print(gunStats[0])
			b.scale.x = 0.255 / 2
			b.scale.y = 0.045 / 2
			shootTimer.start(shootDelayS)
			pelletC += 1
		
	if Input.is_action_just_pressed("CheckDB"):
		if a < gunSelection.size() - 1:
			a += 1
		else:
			a = 0
		GunStates.selectGun(gunSelection[a])
		gunStats = GunStates.getCurrentGunStats()
		print(gunStats)
		shootDelayS = gunStats[0]
		GLOBALS.bulletDamage = gunStats[1]
		GLOBALS.bulletSpeed = gunStats[2]
		spread = gunStats[3]
		pellets = gunStats[4]
		GLOBALS.bulletDeviation = gunStats[5]
		knockback = gunStats[6]
		shootTimer.stop()
	$GPUParticles2D.process_material.set("direction", rotation_degrees)
	look_at(get_global_mouse_position())

	move_and_slide()

func _on_spawn_timer_timeout():
	if badSpawn:
		get_tree().reload_current_scene()
		badSpawn = false
	else:
		camera.enabled = true
		$Area2D/CollisionShape2D.disabled = true

func _on_area_2d_body_entered(_body):
	if not spawnTimer.is_stopped():
		badSpawn = true

func add_force(force : float):
	var direction = self.rotation
	velocity = velocity.lerp(Vector2(cos(direction), sin(direction)) * -force, 0.2)
