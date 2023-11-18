extends CharacterBody2D

@export var speed = 500
@export var friction = 0.25
@export var acceleration = 0.5
@export var ogZoom = 1
@export var shootDelayS = 0.1

@export var Bullet : PackedScene

@onready var shootTimer = $shootTimerDelay
@onready var camera = $Camera2D

var gunSelection : Array
var a = 0

func _ready():
	gunSelection = GunStates.getData()
	shootDelayS = GunStates.getCurrentGunStats()[0]
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
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2(0,0), friction)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootTimer.is_stopped():
		var b = Bullet.instantiate()
		b.add_to_group("Bullets")
		get_parent().add_child(b)
		b.transform = $Muzzle.global_transform
		b.scale.x = 0.255
		b.scale.y = 0.045
		shootTimer.start(shootDelayS)
		
	if Input.is_action_just_pressed("CheckDB"):
		if a < gunSelection.size() - 1:
			a += 1
		else:
			a = 0
		GunStates.selectGun(gunSelection[a])
		shootDelayS = GunStates.getCurrentGunStats()[0]
		shootTimer.stop()

	look_at(get_global_mouse_position())
	
	move_and_slide()
