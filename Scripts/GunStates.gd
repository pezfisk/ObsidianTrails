extends Node

# Path to save file 
var file= "res://GunConfig.cfg"

func getData():
	var configFile = ConfigFile.new()
	
	# Check if theres a GunConfig file already, so it doesnt get overwritten
	if (FileAccess.open(file,FileAccess.READ)):
		configFile.load(file)
	else:
		configFile.new()
		
	return configFile.get_sections()

func SaveData(Header, Adress, Value): 
	
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


func loadData(Header, Adress): 

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
			return loadedData
			
		else:
			push_warning("Has no section key (Adress doesn't exist)! - Section Key requested: " + Adress)
	else:
		push_warning("Has no section (Header doesn't exist)! - Section requested: " + Header)
