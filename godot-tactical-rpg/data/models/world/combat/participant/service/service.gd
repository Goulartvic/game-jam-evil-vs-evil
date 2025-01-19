class_name TacticsParticipantService
extends RefCounted
## Service class for TacticsParticipant
## 
## Dependency of: [TacticsParticipant]

## Resource containing participant data and configurations
var res: TacticsParticipantResource
## Resource for camera-related data and configurations
var camera: TacticsCameraResource
## Resource for control-related data and configurations
var controls: TacticsControlsResource
## Service handling turn-related logic
var turn_service: TacticsParticipantTurnService
## Service handling combat-related logic
var combat_service: TacticsParticipantCombatService


## Initializes the TacticsParticipantService
##
## @param _res: The TacticsParticipantResource to use
## @param _camera: The TacticsCameraResource to use
## @param _controls: The TacticsControlsResource to use
func _init(_res: TacticsParticipantResource, _camera: TacticsCameraResource, _controls: TacticsControlsResource) -> void:
	res = _res
	camera = _camera
	controls = _controls
	turn_service = TacticsParticipantTurnService.new(res, camera, controls)
	combat_service = TacticsParticipantCombatService.new(res, camera, controls)


## Sets up the TacticsParticipantService
##
## @param _participant: The TacticsParticipant node to set up
func setup(_participant: TacticsParticipant) -> void:
	if not controls:
		push_error("TacticsControls needs a ControlResource from /data/models/view/control/tactics/")
	if not camera:
		push_error("TacticsCamera needs a CameraResource from /data/models/view/camera/tactics/")
	if not res:
		push_error("TacticsParticipant needs a ParticipantResource from /data/models/world/combat/participant/")


## Handles the participant's action
##
## @param delta: Time elapsed since the last frame
## @param is_player: Whether the acting participant is the player
## @param parent: The parent node of the participant
## @param participant: The TacticsParticipant node
func act(delta: float, is_player: bool, parent: Node3D, participant: TacticsParticipant) -> void:
	DebugLog.debug_nospam("participant_turn", is_player)
	DebugLog.debug_nospam("turn_stage", res.stage)
	
	if is_player:
		var player: TacticsPlayer = parent as TacticsPlayer
		turn_service.handle_player_turn(delta, player, participant)
	else:
		var opponent: TacticsOpponent = parent as TacticsOpponent
		turn_service.handle_opponent_turn(delta, opponent, participant)


## Configures the service with camera and control resources
##
## @param my_camera: The camera resource to use
## @param my_control: The control resource to use
func configure(my_camera: Resource, my_control: Resource) -> void:
	camera = my_camera
	controls = my_control


## Checks if the participant is properly configured
##
## @param parent: The parent node of the participant
## @return: Whether the participant is configured
func is_configured(parent: Node3D) -> bool:
	return parent.is_pawn_configured()


## Checks if the participant can perform an action
##
## @param parent: The parent node of the participant
## @return: Whether the participant can act
func can_act(parent: Node3D) -> bool:
	return turn_service.can_act(parent)


## Resets the participant's turn
##
## @param parent: The parent node of the participant
func reset_turn(parent: Node3D) -> void:
	turn_service.reset_turn(parent)


## Skips the participant's turn
##
## @param player: The TacticsPlayer node
func skip_turn(player: TacticsPlayer) -> void:
	turn_service.skip_turn(player)
