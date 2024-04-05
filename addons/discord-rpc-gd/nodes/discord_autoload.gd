## This is a GDscript Node wich gets automatically added as Autoload while installing the addon.
## 
## It can run in the background to comunicate with Discord.
## You don't need to use it. If you remove it make sure to run [code]DiscordRPC.run_callbacks()[/code] in a [code]_process[/code] function.
##
## @tutorial: https://github.com/vaporvee/discord-rpc-godot/wiki
extends Node

func _ready() -> void:
	# Application ID
	DiscordRPC.app_id = 1224495101946892369
	# this is boolean if everything worked
	print("Discord working: " + str(DiscordRPC.get_is_discord_working()))
	# Set the first custom text row of the activity here
	DiscordRPC.details = "skrrr"
	# Set the second custom text row of the activity here
	DiscordRPC.state = "Testy Test hehe"
	# Image key for small image from "Art Assets" from the Discord Developer website
	DiscordRPC.large_image = "godot"
	# Tooltip text for the large image
	DiscordRPC.large_image_text = "Game in development!"
	# Image key for large image from "Art Assets" from the Discord Developer website
	DiscordRPC.small_image = "boss"
	# Tooltip text for the small image
	DiscordRPC.small_image_text = "Fighting the end boss! D:"
	# "02:41 elapsed" timestamp for the activity
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	# "59:59 remaining" timestamp for the activity
	#DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600
	# Always refresh after changing the values!
	DiscordRPC.refresh() 

func  _process(_delta) -> void:
	DiscordRPC.run_callbacks()
