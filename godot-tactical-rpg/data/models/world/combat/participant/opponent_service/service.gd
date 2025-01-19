class_name TacticsOpponentService
extends RefCounted
## Service class for TacticsOpponent

## Resource containing participant data and configurations
var res: TacticsParticipantResource
## Resource for camera-related data and configurations
var camera: TacticsCameraResource
## Resource for control-related data and configurations
var controls: TacticsControlsResource
## Reference to the TacticsArena node
var arena: TacticsArena


## Initializes the TacticsOpponentService
##
## @param _res: The TacticsParticipantResource to use
## @param _camera: The TacticsCameraResource to use
## @param _controls: The TacticsControlsResource to use
## @param _arena: The TacticsArena node to use
func _init(_res: TacticsParticipantResource, _camera: TacticsCameraResource, _controls: TacticsControlsResource, _arena: TacticsArena) -> void:
	res = _res
	camera = _camera
	controls = _controls
	arena = _arena


## Checks if all opponent pawns are properly configured
##
## @param opponent: The TacticsOpponent node to check
## @return: Whether all pawns are configured
func is_pawn_configured(opponent: TacticsOpponent) -> bool:
	for pawn: TacticsPawn in opponent.get_children():
		if not pawn.center():
			return false
	return true


## Selects a pawn for the opponent to control
##
## @param opponent: The TacticsOpponent node
func choose_pawn(opponent: TacticsOpponent) -> void:
	arena.reset_all_tile_markers()
	for p: TacticsPawn in opponent.get_children():
		if p.can_act() and p.is_alive():
			res.curr_pawn = p
			res.stage = res.STAGE_SHOW_ACTIONS
			return


## Initiates the opponent's pawn to chase the nearest enemy
##
## @param opponent: The TacticsOpponent node
## @param player_node: The player's node
func chase_nearest_enemy(opponent: TacticsOpponent, player_node: Node) -> void:
	if res.curr_pawn.res.can_move:
		arena.reset_all_tile_markers()
		arena.process_surrounding_tiles(res.curr_pawn.get_tile(), res.curr_pawn.stats.movement, opponent.get_children())
		arena.mark_reachable_tiles(res.curr_pawn.get_tile(), res.curr_pawn.stats.movement)
		
		var to: TacticsTile = arena.get_nearest_target_adjacent_tile(res.curr_pawn, player_node.get_children())
		res.curr_pawn.res.pathfinding_tilestack = arena.get_pathfinding_tilestack(to)
		camera.target = to
		if DebugLog.debug_enabled:
			print_rich("[color=orange]", res.curr_pawn, " moving to [i]", to, "[/i][/color]")
			print_rich("[color=orange]Through: [i]", res.curr_pawn.res.pathfinding_tilestack, "[/i][/color]")
			print_rich("[color=cyan]Camera target updated to destination tile.[/color]")
		res.stage = res.STAGE_SHOW_MOVEMENTS
	else:
		res.stage = res.STAGE_SELECT_PAWN
		push_error("Tried to make a pawn that cannot move chase nearest enemy: ", res.curr_pawn)


## Checks if the opponent's pawn has finished moving
func is_pawn_done_moving() -> void:
	if res.curr_pawn.res.pathfinding_tilestack.is_empty():
		if DebugLog.debug_enabled:
			print_rich("[color=orange]Pawn is done moving.[/color]")
		res.stage = res.STAGE_SELECT_LOCATION


## Selects a pawn for the opponent to attack
func choose_pawn_to_attack() -> void:
	arena.reset_all_tile_markers()
	arena.process_surrounding_tiles(res.curr_pawn.get_tile(), res.curr_pawn.stats.attack_range)
	arena.mark_attackable_tiles(res.curr_pawn.get_tile(), res.curr_pawn.stats.attack_range)
	
	res.attackable_pawn = arena.get_weakest_attackable_pawn(res.targets.get_children())
	if res.attackable_pawn:
		if DebugLog.debug_enabled:
			print_rich("[color=orange]Weakest target detected:", res.attackable_pawn, "[/color]")
		controls.set_actions_menu_visibility(true, res.attackable_pawn)
		camera.target = res.attackable_pawn
	else:
		if DebugLog.debug_enabled:
			print_rich("[color=orange]No target detected.[/color]")
		
	res.stage = res.STAGE_MOVE_PAWN
