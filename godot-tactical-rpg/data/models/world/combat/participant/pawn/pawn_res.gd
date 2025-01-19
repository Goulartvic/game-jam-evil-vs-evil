class_name TacticsPawnResource
extends Resource
## Resource class for managing pawn data and state in the tactics game

## Signal emitted when the pawn moves
signal pawn_moved
## Signal emitted when the pawn attacks
signal pawn_attacked
## Signal emitted when the pawn's turn ends
signal turn_ended

## Minimum height difference required for the pawn to jump
const MIN_HEIGHT_TO_JUMP: int = 1
## Strength of gravity applied to the pawn
const GRAVITY_STRENGTH: int = 7
## Minimum time required for an attack animation
const MIN_TIME_FOR_ATTACK: float = 1.0
## Number of frames in the pawn's animation
const ANIMATION_FRAMES: int = 1

## Whether the pawn's HUD is currently enabled
var pawn_hud_enabled: bool = false
## Whether the pawn can move
var can_move: bool = true
## Whether the pawn can attack
var can_attack: bool = true
## Whether the pawn is currently jumping
var is_jumping: bool = false
## Whether the pawn is currently moving
var is_moving: bool = false

## The direction the pawn is moving in
var move_direction: Vector3 = Vector3.ZERO
## Stack of tiles representing the pawn's pathfinding route
var pathfinding_tilestack: Array[Variant] = []
## Current gravity vector applied to the pawn
var gravity: Vector3 = Vector3.ZERO
## Delay before the pawn can perform its next action
var wait_delay: float = 0.0
## Speed at which the pawn walks
var walk_speed: int = TacticsConfig.pawn.base_walk_speed


## Resets the pawn's turn, allowing it to move and attack again
func reset_turn() -> void:
	can_move = true
	can_attack = true


## Ends the pawn's turn, preventing further actions and emitting the turn_ended signal
func end_pawn_turn() -> void:
	can_move = false
	can_attack = false
	turn_ended.emit()


## Sets the pawn's moving state and emits the pawn_moved signal if true
##
## @param value: Whether the pawn is moving or not
func set_moving(value: bool) -> void:
	is_moving = value
	if value:
		pawn_moved.emit()


## Sets the pawn's attacking state and emits the pawn_attacked signal if false
##
## @param value: Whether the pawn can attack or not
func set_attacking(value: bool) -> void:
	can_attack = value
	if not value:
		pawn_attacked.emit()
