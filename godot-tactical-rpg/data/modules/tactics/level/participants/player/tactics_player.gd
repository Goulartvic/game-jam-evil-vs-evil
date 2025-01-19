class_name TacticsPlayer
extends TacticsParticipant
## Handles player-specific actions and logic in the tactics game
## 
## Extends TacticsParticipant to provide player-specific functionality
## Service: [TacticsPlayerService]

## Service handling player-specific logic and operations
var player_serv: TacticsPlayerService


## Initializes the TacticsPlayer node
func _ready() -> void:
	# Call the parent class's _ready function
	super._ready()
	# Initialize the player service with necessary resources
	player_serv = TacticsPlayerService.new(res, camera, controls, arena)


## Processes player-related physics updates
##
## @param _delta: Time elapsed since the last frame (unused)
func _physics_process(_delta: float) -> void:
	# Toggle the display of enemy stats
	player_serv.toggle_enemy_stats(get_node("../TacticsOpponent"))


## Checks if the player's pawn is properly configured
##
## @return: Whether the player's pawn is configured
func is_pawn_configured() -> bool:
	return player_serv.is_pawn_configured(self)


## Displays the available actions for the player's pawn
func show_available_pawn_actions() -> void:
	player_serv.show_available_pawn_actions()


## Displays the available movement options for the player's pawn
func show_available_movements() -> void:
	player_serv.show_available_movements()


## Displays the attackable targets for the player's pawn
func display_attackable_targets() -> void:
	player_serv.display_attackable_targets()


## Initiates the movement of the player's pawn
func move_pawn() -> void:
	player_serv.move_pawn()
