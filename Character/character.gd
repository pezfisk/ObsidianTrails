extends CharacterBody2D

@export var speed = 500
@export var friction = 0.25
@export var acceleration = 0.5
@export var ogZoom = 1
@export var shootDelayS = 0.1

@export var Bullet : PackedScene

@onready var shootDelay = $shootTimerDelay
@onready var camera = $Camera2D

var text = 0

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
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootDelay.is_stopped():
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.transform = $Muzzle.global_transform
		b.scale.x = 0.255
		b.scale.y = 0.045
		text += 1
		shootDelay.start(shootDelayS)
		
	if Input.is_action_just_pressed("CheckDB"):
		GunStates.SaveData("Test", "TotalA", text)
		var a = GunStates.loadData("a", "Ammo")
		print(a)
		
	look_at(get_global_mouse_position())
	
	move_and_slide()
