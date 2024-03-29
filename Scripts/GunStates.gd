extends Node
## A brief description of the class's role and functionality.
##
## The description of the script, what it can do,
## and any further detail.
##
## @experimental

class_name GunScript

# Path to save file 
var file= "res://Config/GunConfig.cfg"

# GLOBAL VARIABLES
var adressArray = ["shootDelay", "power", "speed", "spread", "pellet", "deviation", "knockback"]
var speed = 0
var deviation = 0
var damage = 0

func getData():
	var configFile = ConfigFile.new()
	
	# Check if theres a GunConfig file already, so it doesnt get overwritten
	if (FileAccess.open(file,FileAccess.READ)):
		configFile.load(file)
	else:
		configFile.new()
		
	return configFile.get_sections()

func SaveData(Header : String, Adress : String, Value): 
	
	var configFile = ConfigFile.new()
	
	# Check if theres a GunConfig file already, so it doesnt get overwritten
	if (FileAccess.open(file,FileAccess.READ)):
		configFile.load(file)
	else:
		configFile.new()
	# Add values to file 
	configFile.set_value(Header,Adress,Value)
 
	# Save file 
	configFile.save(file)

func loadData(Header : String, Adress : String): 

	# Initiate ConfigFile  

	var configFile= ConfigFile.new() 

	# Load file 
	configFile.load(file) 

	# ----------
	var loadedData 

	# METHOD 
	if (configFile.has_section(Header)): 
		if (configFile.has_section_key(Header, Adress)): 
			# Get data value
			loadedData = configFile.get_value(Header, Adress)
			if loadedData == null:
				pass
			return loadedData
			
		else:
			push_warning("Has no section key (Adress doesn't exist)! - Section Key requested: " + Adress)
	else:
		push_warning("Has no section (Header doesn't exist)! - Section requested: " + Header)

func getCurrentGun():
	var guns = getData()
	var i = 0
	while i < guns.size():
		i += 1
		if loadData(guns[i-1], "selected"):
			return [i-1, guns[i-1]]

func selectGun(Header : String):
	
	var configFile = ConfigFile.new()
	
	configFile.load(file)
	
	if Header != getCurrentGun()[1]:
		configFile.set_value(Header, "selected", true)
		configFile.set_value(getCurrentGun()[1], "selected", false)
		
	# Save file 
	configFile.save(file)

func getCurrentGunStats(fromSelectGun : bool = false):
	var currentGun = getCurrentGun()
	var i = 0
	var gunStats : Array = []
	while i < adressArray.size():
		i += 1
		gunStats.append(loadData(currentGun[1], adressArray[i-1]))
	
	return gunStats

# I dont understand why this doesnt fucking work
func getGunStats(gun : String):
	var i = 0
	var gunStats : Array = []
	while i < adressArray.size():
		i += 1
		gunStats.append(loadData(gun, adressArray[i-1]))
	
	return gunStats
