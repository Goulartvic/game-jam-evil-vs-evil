class_name TacticsControlsService
extends RefCounted
## Service class for managing tactics controls and related functionalities.

## Reference to the TacticsControlsResource.
var controls: TacticsControlsResource
## Reference to the TacticsCameraResource.
var t_cam: TacticsCameraResource
## Reference to the TacticsParticipantResource.
var participant: TacticsParticipantResource
## Reference to the TacticsArenaResource.
var arena: TacticsArenaResource
## Node for capturing mouse clicks.
var mouse_click_capture: Node
## Service for handling input-related operations.
var input_service: TacticsControlsInputService
## Service for managing UI-related operations.
var ui_service: TacticsUIService
## Service for handling camera-related operations.
var camera_service: TacticsControlsCameraService
## Service for managing pawn selection operations.
var pawn_selection_service: TacticsControlsSelectionService


## Initializes the TacticsControlsService with necessary resources and services.
func _init(_controls: TacticsControlsResource, _t_cam: TacticsCameraResource, _participant: TacticsParticipantResource, _arena: TacticsArenaResource, _mouse_click_capture: Node) -> void:
	controls = _controls
	t_cam = _t_cam
	participant = _participant
	arena = _arena
	mouse_click_capture = _mouse_click_capture
	input_service = TacticsControlsInputService.new(controls, mouse_click_capture)
	ui_service = TacticsUIService.new(controls)
	camera_service = TacticsControlsCameraService.new(t_cam)
	pawn_selection_service = TacticsControlsSelectionService.new(participant, arena, controls, t_cam, input_service)


## Sets up signal connections and performs initial checks.
func setup(ctrl: TacticsControls) -> void:
	if not controls:
		push_error("TacticsControls needs a ControlResource from /data/models/view/controls/tactics/")
	else:
		controls.connect("called_set_actions_menu_visibility", ctrl.set_actions_menu_visibility)
		controls.connect("called_move_camera", ctrl.move_camera)
		controls.connect("called_camera_rotation", ctrl.camera_rotation_inputs)
		controls.connect("called_set_cursor_shape_to_move", ctrl.set_cursor_shape_to_move)
		controls.connect("called_set_cursor_shape_to_arrow", ctrl.set_cursor_shape_to_arrow)
		controls.connect("called_select_pawn", ctrl.select_pawn)
		controls.connect("called_select_pawn_to_attack", ctrl.select_pawn_to_attack)
		controls.connect("called_select_new_location", ctrl.select_new_location)
	if not t_cam:
		push_error("TacticsCamera needs a CameraResource (T Cam) from /data/models/view/camera/tactics/")
	if not arena:
		push_error("TacticsControls needs an ArenaResource from /data/models/world/combat/arena/")


## Performs physics processing tasks.
func physics_process(_delta: float, ctrl: TacticsControls) -> void:
	input_service.update_mouse_mode()
	ui_service.update_controller_hints(ctrl)


## Handles input events.
func handle_input(event: InputEvent) -> void:
	input_service.handle_input(event)


## Delegates camera movement to the camera service.
func move_camera(delta: float) -> void:
	camera_service.move_camera(delta, controls.is_joystick)


## Delegates camera rotation inputs to the camera service.
func camera_rotation_inputs(delta: float) -> void:
	camera_service.handle_rotation_inputs(delta)


## Delegates setting actions menu visibility to the UI service.
func set_actions_menu_visibility(v: bool, p: TacticsPawn, ctrl: TacticsControls) -> void:
	ui_service.set_actions_menu_visibility(v, p, ctrl)


## Delegates pawn selection to the pawn selection service.
func select_pawn(player: TacticsPlayer, ctrl: TacticsControls) -> void:
	pawn_selection_service.select_pawn(player, ctrl)


## Delegates new location selection to the pawn selection service.
func select_new_location(ctrl: TacticsControls) -> void:
	pawn_selection_service.select_new_location(ctrl)


## Delegates pawn attack selection to the pawn selection service.
func select_pawn_to_attack(ctrl: TacticsControls) -> void:
	pawn_selection_service.select_pawn_to_attack(ctrl)


## Handles player's move action.
func player_wants_to_move() -> void:
	pawn_selection_service.player_wants_to_move()


## Handles player's cancel action.
func player_wants_to_cancel() -> void:
	pawn_selection_service.player_wants_to_cancel()


## Handles player's wait action.
func player_wants_to_wait() -> void:
	pawn_selection_service.player_wants_to_wait()


## Handles player's skip turn action.
func player_wants_to_skip_turn() -> void:
	pawn_selection_service.player_wants_to_skip_turn()


## Handles player's attack action.
func player_wants_to_attack() -> void:
	pawn_selection_service.player_wants_to_attack()
