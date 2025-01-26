extends Node
## A placeholder script that is meant to be replaced by your own level loader system

#region: --- Props ---
## The current instance of the TacticsLevel
var level_instance: TacticsLevel
var master_volume = AudioServer.get_bus_index("Master")
var music_volume = AudioServer.get_bus_index("Music")
var sfx_volume = AudioServer.get_bus_index("SFX")

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

## Reference to the World node
@onready var world: Node3D = $World
## Reference to the demo map button
@onready var demo_map: Button = $UI/MapSelector/LoadMap0
#endregion

#region: --- Processing ---
## Called when the node enters the scene tree for the first time
func _ready() -> void:
	demo_map.grab_focus() # Set focus on the demo map button
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("audio", "master_volume",1.0)
		config.set_value("audio", "music_volume",1.0)
		config.set_value("audio", "sfx_volume",1.0)
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
		AudioServer.set_bus_volume_db(master_volume, linear_to_db(config.get_value("audio", "master_volume")))
		AudioServer.set_bus_volume_db(music_volume, linear_to_db(config.get_value("audio", "music_volume")))
		AudioServer.set_bus_volume_db(sfx_volume, linear_to_db(config.get_value("audio", "sfx_volume")))
		$UI/Settings/MasterSlider.value = db_to_linear(master_volume)
		$UI/Settings/MusicSlider.value = db_to_linear(music_volume)
		$UI/Settings/SfxSlider.value = db_to_linear(sfx_volume)
#endregion

#region: --- Signals ---
## Called when the Load Map 0 button is pressed
func _on_load_map_0_pressed() -> void:
	load_level("test") # Load the test level
## Called when the Load Map 0 button is pressed
func _on_load_map_1_pressed() -> void:
	load_level("test") # Load the test level
func _on_load_settings_pressed() -> void:
	swap_settings() # Load the test level
#endregion


#region: --- Methods ---
## Unloads the current level instance
func unload_level() -> void:
	if is_instance_valid(level_instance): # Check if the level instance is valid
		level_instance.queue_free() # Free the current level instance
	level_instance = null # Reset the level instance variable

## Loads the current level instance -- clears existing level in the process
##
## @param level_name: The name of the level to load
func load_level(level_name: String) -> void:
	unload_level() # Unload the current level
	var level_path: String = "res://assets/maps/level/%s_level.tscn" % level_name # Construct the level path
	level_instance = load(level_path).instantiate() # Load and instantiate the new level
	world.add_child(level_instance) # Add the new level to the World node
	$UI/MapSelector.visible = false # Hide the map selector UI
	$UI/Settings.visible = false
	
func swap_settings() -> void:
	$UI/MapSelector.visible = false # Hide the map selector UI
	$UI/Settings.visible = true

func _on_back_pressed() -> void:
	$UI/MapSelector.visible = true # Hide the map selector UI
	$UI/Settings.visible = false

func _on_mastervolume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_volume, linear_to_db(value))
	config.set_value("audio","master_volume",linear_to_db(value))
	config.save(SETTINGS_FILE_PATH)

func _on_musicvolume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_volume, linear_to_db(value))
	config.set_value("audio","music_volume",linear_to_db(value))
	config.save(SETTINGS_FILE_PATH)

func _on_sfxvolume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_volume, linear_to_db(value))
	config.set_value("audio","sfx_volume",linear_to_db(value))
	config.save(SETTINGS_FILE_PATH)

func _on_team0_pawn0_selected(index: int) -> void:
	print(index)
	#TODO add Team 0 Pawn 0
func _on_team0_pawn1_selected(index: int) -> void:
	print(index)
	#TODO add Team 0 Pawn 1
func _on_team0_pawn2_selected(index: int) -> void:
	print(index)
	#TODO add Team 0 Pawn 2
func _on_team0_pawn3_selected(index: int) -> void:
	print(index)
	#TODO add Team 0 Pawn 3
func _on_team1_pawn0_selected(index: int) -> void:
	print(index)
	#TODO add Team 1 Pawn 0
func _on_team1_pawn1_selected(index: int) -> void:
	print(index)
	#TODO add Team 1 Pawn 1
func _on_team1_pawn2_selected(index: int) -> void:
	print(index)
	#TODO add Team 1 Pawn 2
func _on_team1_pawn3_selected(index: int) -> void:
	print(index)
	#TODO add Team 1 Pawn 3


#endregion