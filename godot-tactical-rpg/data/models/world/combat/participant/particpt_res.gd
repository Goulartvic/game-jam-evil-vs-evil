class_name TacticsParticipantResource
extends Resource
## Attributes & signals of the tactics participant.
## 
## Dependency of: [TacticsParticipant]

## Signal emitted when a turn is skipped by player1
signal called_skip_turn_player1

## Signal emitted when a turn is skipped by player2
signal called_skip_turn_player2

#region Stage Selection
## Constant for the pawn selection stage
const STAGE_SELECT_PAWN: int = 0
## Constant for the action display stage
const STAGE_SHOW_ACTIONS: int = 1
## Constant for the movement display stage
const STAGE_SHOW_MOVEMENTS: int = 2
## Constant for the location selection stage
const STAGE_SELECT_LOCATION: int = 3
## Constant for the pawn movement stage
const STAGE_MOVE_PAWN: int = 4
## Constant for the target display stage
const STAGE_DISPLAY_TARGETS: int = 5
## Constant for the attack target selection stage
const STAGE_SELECT_ATTACK_TARGET: int = 6
## Constant for the attack execution stage
const STAGE_ATTACK: int = 7
## The current stage of the participant's turn
var stage: int = 0
#endregion

## The currently active pawn
var curr_pawn: TacticsPawn = null:
	set(val):
		curr_pawn = val
		DebugLog.debug_nospam("pawn", val)
## The pawn that can be attacked
var attackable_pawn: TacticsPawn = null
## The node containing the target pawns
var targets: Node = null

## Flag to control the display of opponent stats
var display_opponent_stats: bool = false
## Flag indicating if the turn has just started
var turn_just_started: bool = true


## Emits the skip_turn signal from player1
func skip_turn_player1() -> void:
	called_skip_turn_player1.emit()

## Emits the skip_turn signal from player1
func skip_turn_player2() -> void:
	called_skip_turn_player2.emit()
