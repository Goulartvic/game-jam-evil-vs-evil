@tool
class_name Expertise
extends Node
## The expertise of a game actor.
##
## Assigns a set of stats to a pawn, 

## Resource containing initial stats for the actor
@export var starting_stats: StatsResource
## Array of initial skills for the actor
@export var starting_skills: Array[String]

## Node containing the actor's stats
@onready var stats: Stats = $Stats


func _ready() -> void:
	if not starting_stats:
		push_error("Expertise needs a StatsResource (Starting Stats) from /data/models/stats/") # Error if starting stats are not set
	stats.init(starting_stats) # Initialize stats from the starting_stats resource
	
func configure_stats(new_stats: Dictionary) -> void:
	if not stats:
		push_error("Stats not found")
		return
	
	for stat_name in new_stats.keys():
		if stat_name in stats:
			stats[stat_name] = new_stats[stat_name]
		else:
			push_warning("Stats unknown: " + stat_name)

func set_expertise(new_expertise: String) -> void:
	if stats:
		stats.expertise = new_expertise
	else:
		push_error("Stats not found to define expertise")
