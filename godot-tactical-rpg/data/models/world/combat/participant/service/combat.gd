class_name TacticsParticipantCombatService
extends RefCounted
## Service class for handling combat-related actions
## 
## Parent: [TacticsParticipantService]

## Resource containing participant data and configurations
var res: TacticsParticipantResource
## Resource for camera-related data and configurations
var camera: TacticsCameraResource
## Resource for control-related data and configurations
var controls: TacticsControlsResource


## Initializes the TacticsParticipantCombatService
##
## @param _res: The TacticsParticipantResource to use
## @param _camera: The TacticsCameraResource to use
## @param _controls: The TacticsControlsResource to use
func _init(_res: TacticsParticipantResource, _camera: TacticsCameraResource, _controls: TacticsControlsResource) -> void:
	res = _res
	camera = _camera
	controls = _controls


## Handles the attack action of a pawn
##
## @param delta: Time elapsed since the last frame
## @param is_player: Whether the attacking pawn belongs to the player
func attack_pawn(delta: float, is_player: bool) -> void:
	# Handle case when no attackable pawn is available
	if not res.attackable_pawn:
		res.curr_pawn.res.can_attack = false
	else:
		# Attempt to attack the target pawn
		if not res.curr_pawn.attack_target_pawn(res.attackable_pawn, delta):
			return
		# Hide actions menu and focus camera on attacking pawn
		controls.set_actions_menu_visibility(false, res.attackable_pawn)
		camera.target = res.curr_pawn
	
	# Reset attackable pawn
	res.attackable_pawn = null
	# Reset opponent stats display
	if res.display_opponent_stats:
		res.display_opponent_stats = false
	
	# Determine next stage based on current pawn's ability to act and whether it's a player pawn
	if not res.curr_pawn.can_act() or not is_player:
		res.stage = res.STAGE_SELECT_PAWN
	elif res.curr_pawn.can_act() and is_player:
		res.stage = res.STAGE_SHOW_ACTIONS
