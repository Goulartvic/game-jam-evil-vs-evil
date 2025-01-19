class_name TacticsControlsSelectionService
extends RefCounted
## Service class for managing pawn and tile selection in the Tactics game.

## Reference to the TacticsParticipantResource.
var participant: TacticsParticipantResource
## Reference to the TacticsArenaResource.
var arena: TacticsArenaResource
## Reference to the TacticsControlsResource.
var controls: TacticsControlsResource
## Reference to the TacticsCameraResource.
var t_cam: TacticsCameraResource
## Reference to the TacticsControlsInputService.
var input_service: TacticsControlsInputService


## Initializes the TacticsControlsSelectionService with necessary resources and services.
func _init(_participant: TacticsParticipantResource, _arena: TacticsArenaResource, _controls: TacticsControlsResource, _t_cam: TacticsCameraResource, _input_service: TacticsControlsInputService) -> void:
	participant = _participant
	arena = _arena
	controls = _controls
	t_cam = _t_cam
	input_service = _input_service


## Handles the selection of a pawn.
func select_pawn(player: TacticsPlayer, ctrl: TacticsControls) -> void:
	arena.reset_all_tile_markers()
	if ctrl.curr_pawn:
		controls.set_actions_menu_visibility(false, participant.curr_pawn)
		ctrl.curr_pawn.show_pawn_stats(false)
	
	ctrl.curr_pawn = _select_hovered_pawn(ctrl)
	if not ctrl.curr_pawn:
		return
	else:
		ctrl.curr_pawn.show_pawn_stats(true)
	
	if Input.is_action_just_pressed("ui_accept") and ctrl.curr_pawn.can_act():
		if ctrl.curr_pawn in player.get_children():
			t_cam.target = ctrl.curr_pawn
			participant.curr_pawn = ctrl.curr_pawn
			controls.set_actions_menu_visibility(true, participant.curr_pawn)
			participant.stage = 1


## Selects the pawn currently hovered by the mouse.
func _select_hovered_pawn(ctrl: TacticsControls) -> PhysicsBody3D:
	var pawn: TacticsPawn = input_service.get_3d_canvas_mouse_position(2, ctrl)
	var tile: TacticsTile = input_service.get_3d_canvas_mouse_position(1, ctrl) if not pawn else pawn.get_tile()
	arena.mark_hover_tile(tile)
	return pawn if pawn else tile.get_tile_occupier() if tile else null


## Selects the tile currently hovered by the mouse.
func _select_hovered_tile(ctrl: TacticsControls) -> TacticsTile:
	var pawn: TacticsPawn = input_service.get_3d_canvas_mouse_position(2, ctrl)
	var tile: TacticsTile = input_service.get_3d_canvas_mouse_position(1, ctrl) if not pawn else pawn.get_tile()
	arena.mark_hover_tile(tile)
	return tile


## Handles the selection of a new location for the current pawn.
func select_new_location(ctrl: TacticsControls) -> void:
	var tile: TacticsTile = input_service.get_3d_canvas_mouse_position(1, ctrl)
	arena.mark_hover_tile(tile)
	if Input.is_action_just_pressed("ui_accept") and tile and tile.reachable:
		ctrl.curr_pawn.res.pathfinding_tilestack = arena.get_pathfinding_tilestack(tile)
		t_cam.target = tile
		participant.stage = 4


## Handles the selection of a pawn to attack.
func select_pawn_to_attack(ctrl: TacticsControls) -> void:
	controls.set_actions_menu_visibility(true, participant.curr_pawn)
	if participant.attackable_pawn:
		controls.set_actions_menu_visibility(false, participant.attackable_pawn)
		participant.attackable_pawn.show_pawn_stats(false)
	var tile: TacticsTile = _select_hovered_tile(ctrl)
	participant.attackable_pawn = tile.get_tile_occupier() if tile else null
	if participant.attackable_pawn:
		controls.set_actions_menu_visibility(true, participant.attackable_pawn)
		participant.attackable_pawn.show_pawn_stats(true)
	if Input.is_action_just_pressed("ui_accept") and tile and tile.attackable:
		t_cam.target = participant.attackable_pawn
		participant.stage = 7


## Handles the player's intention to move.
func player_wants_to_move() -> void:
	if participant.display_opponent_stats:
		participant.display_opponent_stats = false
	participant.stage = 2


## Handles the player's intention to cancel.
func player_wants_to_cancel() -> void:
	if participant.display_opponent_stats:
		participant.display_opponent_stats = false
	participant.stage = 1 if participant.stage > 1 else 0


## Handles the player's intention to wait.
func player_wants_to_wait() -> void:
	if participant.display_opponent_stats:
		participant.display_opponent_stats = false
	participant.curr_pawn.end_pawn_turn()
	participant.stage = 0


## Handles the player's intention to skip turn.
func player_wants_to_skip_turn() -> void:
	if participant.display_opponent_stats:
		participant.display_opponent_stats = false
	participant.skip_turn()


## Handles the player's intention to attack.
func player_wants_to_attack() -> void:
	participant.stage = 5
