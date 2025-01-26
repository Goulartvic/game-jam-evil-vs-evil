class_name TacticsLevel
extends Node3D
## Tactics system initialization & turn_stage management.
##
## This is the Tactics Level's topmost script.[br][br]
## Dependencies: [TacticsArena], [TacticsTile], [TacticsCamera], [TacticsControls], [TacticsParticipant], [TacticsOpponent], [TacticsPlayer], [TacticsPawn]

#region: --- Props ---
## Camera resource for the tactics system
@export var camera: TacticsCameraResource = load("res://data/models/view/camera/tactics/camera.tres")
## Radius of the camera boundary
@export var camera_boundary_radius: float = 10.0
## UI control resource for the tactics system
@export var ui_control: TacticsControlsResource = load("res://data/models/view/control/tactics/control.tres")
## Reference to the TacticsParticipant node
var participant: TacticsParticipant
## Reference to the TacticsPlayer1 node
var player1: TacticsPlayer1 = null
## Reference to the TacticsPlayer1 node
var player2: TacticsPlayer2 = null
## Reference to the TacticsOpponent node
var opponent: TacticsOpponent
## Reference to the TacticsArena node
var arena: TacticsArena
## Current turn stage (0: init, 1: handle)
var turn_stage: int = 0
#endregion

#region: --- Processing ---
func _ready() -> void:
	if not ui_control:
		push_error("TacticsControls needs a ControlResource from /data/models/view/control/tactics/")
	if not camera:
		push_error("TacticsCamera needs a CameraResource from /data/models/view/camera/tactics/")
	
	# Initialize node references
	participant = $TacticsParticipant
	player1 = $TacticsParticipant/TacticsPlayer1
	player2 = $TacticsParticipant/TacticsPlayer2
	opponent = $TacticsParticipant/TacticsOpponent
	arena = $TacticsArena
	
	arena.configure_tiles() # Configure arena tiles
	participant.configure(camera, ui_control) # Configure participant with camera and UI control
	
	# Update camera boundary radius if necessary
	if camera.boundary_radius != camera_boundary_radius:
		camera.boundary_radius = camera_boundary_radius

func _physics_process(delta: float) -> void:
	match turn_stage:
		0: _init_turn() # Initialize turn
		1: _handle_turn(delta) # Handle ongoing turn
#endregion

#region: --- Methods ---
## Checks requirements to begin the first turn.[br]Used by [TacticsPlayer], [TacticsOpponent]
func _init_turn() -> void:
	if participant.is_configured(player1) and participant.is_configured(player2):
		turn_stage = 1 # Move to turn handling stage if both player and opponent are configured

## Turn state management.[br]Used by [TacticsPlayer], [TacticsOpponent]
func _handle_turn(delta: float) -> void:
	DebugLog.debug_nospam("player1_can_act", participant.can_act(player1))
	
	if participant.can_act(player1):
		if not participant.is_configured(player1):
			participant.configure(camera, ui_control) # Configure player1 if not already done
		participant.act(delta, true, player1) # Player's turn to act
		
	elif participant.can_act(player2):
		if not participant.is_configured(player2):
			participant.configure(camera, ui_control) # Configure opponent if not already done
		participant.act(delta, false, player2) # Player2's turn to act
		
	else:
		if DebugLog.debug_enabled:
			print_rich("[color=green]0Oo◦° O-----------------------------------O °◦oO0[/color]")
			print_rich("[color=green]0Oo◦°[/color][color=red] >}=----->> [/color][color=yellow][ Turn reset! ][/color][color=red] <<-----={< [/color][color=green]°◦oO0[/color]")
			print_rich("[color=green]0Oo◦° O-----------------------------------O °◦oO0[/color]")
		player1.reset_turn(player1) # Reset player1's turn
		player2.reset_turn(player2) # Reset player2's turn
#endregion
