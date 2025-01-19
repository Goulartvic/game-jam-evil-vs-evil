extends Node
## A placeholder script that is meant to be replaced by your own level loader system

#region: --- Props ---
## The current instance of the TacticsLevel
var level_instance: TacticsLevel

## Reference to the World node
@onready var world: Node3D = $World
## Reference to the demo map button
@onready var demo_map: Button = $UI/MapSelector/LoadMap0
#endregion

#region: --- Processing ---
## Called when the node enters the scene tree for the first time
func _ready() -> void:
	demo_map.grab_focus() # Set focus on the demo map button
#endregion

#region: --- Signals ---
## Called when the Load Map 0 button is pressed
func _on_load_map_0_pressed() -> void:
	load_level("test") # Load the test level
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
#endregion
