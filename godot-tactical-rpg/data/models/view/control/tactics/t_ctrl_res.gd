class_name TacticsControlsResource
extends Resource
## Resource class for managing tactics controls and related signals.

## Signal emitted when the actions menu visibility needs to be set.
signal called_set_actions_menu_visibility
## Signal emitted when the camera needs to be moved.
signal called_move_camera
## Signal emitted when camera rotation inputs are received.
signal called_camera_rotation
## Signal emitted when a pawn needs to be selected.
signal called_select_pawn
## Signal emitted when a pawn needs to be selected for attack.
signal called_select_pawn_to_attack
## Signal emitted when a new location needs to be selected.
signal called_select_new_location
## Signal emitted when the cursor shape needs to be set to "move".
signal called_set_cursor_shape_to_move
## Signal emitted when the cursor shape needs to be set to "arrow".
signal called_set_cursor_shape_to_arrow

## Indicates whether the current input device is a joystick.
@export var is_joystick: bool
## Indicates whether the input hints are folded.
@export var input_hints_folded: bool

## Dictionary of available actions and their corresponding methods.
var actions: Dictionary = {
	"Move": "_player_wants_to_move",
	"Wait": "_player_wants_to_wait",
	"Cancel": "_player_wants_to_cancel",
	"Attack": "_player_wants_to_attack",
	"Debug_next_turn": "_player_wants_to_skip_turn"
}


## Sets the visibility of the actions menu.
func set_actions_menu_visibility(v: bool, p: TacticsPawn) -> void:
	called_set_actions_menu_visibility.emit(v, p)


## Initiates camera movement.
func move_camera(delta: float) -> void:
	called_move_camera.emit(delta)


## Handles camera rotation inputs.
func camera_rotation_inputs(delta: float) -> void:
	called_camera_rotation.emit(delta)


## Selects a pawn for the given player.
func select_pawn(player: TacticsPlayer) -> void:
	called_select_pawn.emit(player)


## Selects a pawn to attack.
func select_pawn_to_attack() -> void:
	called_select_pawn_to_attack.emit()


## Selects a new location.
func select_new_location() -> void:
	called_select_new_location.emit()


## Sets the cursor shape to "move".
func set_cursor_shape_to_move() -> void:
	called_set_cursor_shape_to_move.emit()


## Sets the cursor shape to "arrow".
func set_cursor_shape_to_arrow() -> void:
	called_set_cursor_shape_to_arrow.emit()
