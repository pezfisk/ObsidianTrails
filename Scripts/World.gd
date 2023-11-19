extends Node2D

@export var Player : PackedScene
@export var Exit : PackedScene
#const Player = preload("res://Character/character.gd")
#const Exit = preload("res://Scenes/ExitDoor.tscn")

var borders = Rect2(1, 1, 82 * 2, 53 * 2)

@onready var tileMap = $Tilemap

func _ready():
	randomize()
	#seed(69)
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(5000)
	
	var player = Player.instantiate()
	add_child(player)
	player.position = map.front()*64
	
	var exit = Exit.instantiate()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	#exit.connect("leaving_level", reload_level())
	
	walker.queue_free()
	for location in map:
		tileMap.set_cell(0, location, -1, Vector2i(0,0))
	#tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
