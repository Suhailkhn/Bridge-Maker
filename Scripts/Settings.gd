extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"score" : {
		"high_score": GLOBAL.high_score
	},
	"diamonds" : {
		"total_diamonds" : GLOBAL.diamonds
	}
} 

func _ready():
	if(load_settings() == -1):
		save_settings()
	

func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if(error != OK):
		print("Error in loading settings. Error code: %s" % error)
		return -1
	
#	var values = []
#	for _section in _settings.keys():
#		for key in _settings[section].keys():
#			var val = _settings[section][key]
#			values.append(_config_file.get_value(section, key, val))
#			print("%s: %s" % [key, val])
#	return values

	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)

func get_setting(category, key):
	return _settings[category][key]

func set_setting(category, key, value):
	_settings[category][key] = value
	save_settings()
