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

func _ready():
	gunSelection = GunStates.getData()
	shootDelayS = GunStates.getCurrentGunStats()[0]
	pellets = GunStates.getCurrentGunStats()[4]
	spread = GunStates.getCurrentGunStats()[3]
	print(gunSelection)

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	#if Input.is_anything_pressed() == false:
		#camera.zoom = Vector2(1,1)
	return input

func _physics_process(_delta):
	
	GLOBALS.playerPos = position
	
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2(0,0), friction)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootTimer.is_stopped():
		var pelletC = 0
		while pelletC < pellets:
			var b = Bullet.instantiate()
			b.add_to_group("Bullets")
			get_parent().add_child(b)
			b.global_position = $Muzzle.global_position
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
		pellets = gunStats[4]
		spread = gunStats[3]
		shootTimer.stop()

	look_at(get_global_mouse_position())

	move_and_slide()

func _on_spawn_timer_timeout():
	if badSpawn:
		get_tree().reload_current_scene()
		badSpawn = false
	else:
		camera.enabled = true

func _on_area_2d_body_entered(body):
	if not spawnTimer.is_stopped():
		badSpawn = true
