extends Node

var player
var bulletSpeed = GunStates.getCurrentGunStats()[2]
var bulletDeviation = GunStates.getCurrentGunStats()[5]
var bulletDamage = GunStates.getCurrentGunStats()[1]

var playerPos : Vector2
