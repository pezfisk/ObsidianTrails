extends Node

var STEAM_APP_ID : int = 480

func _init() -> void:
	# Set Steam app ID
	OS.set_environment("SteamAppId", str(STEAM_APP_ID))
	OS.set_environment("SteamGameId", str(STEAM_APP_ID))
	
func _ready():
	_initialize_Steam()
	
func _initialize_Steam():
	var INIT : Dictionary = Steam.steamInitEx(true)
	print("Did Steam initialize? "+str(INIT))
	if INIT['status'] > 0:
		print("Failed to initialize Steam. "+str(INIT['verbal'])+" Shutting down...")
		get_tree().quit()

	Steam.run_callbacks()
