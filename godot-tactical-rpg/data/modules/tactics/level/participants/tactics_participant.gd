class_name TacticsParticipant
extends Node3D
## Handles participant (i.e. Player & Opponent) actions and decision-making
## 
## Resource Interface: [TacticsParticipantResource] -- Service: [TacticsParticipantService]
## Parent of: [TacticsPlayer], [TacticsOpponent]

## Resource containing participant data and configurations
@export var res: TacticsParticipantResource = load("res://data/models/world/combat/participant/participant.tres")
## Resource for camera-related data and configurations
@export var camera: TacticsCameraResource = load("res://data/models/view/camera/tactics/camera.tres")
## Resource for control-related data and configurations
@export var controls: TacticsControlsResource = load("res://data/models/view/control/tactics/control.tres")
## Service handling participant logic and operations
var serv: TacticsParticipantService
## Reference to the TacticsArena node
@onready var arena: TacticsArena = %TacticsArena
## Reference to the TacticsPlayer1 node
@onready var player1: TacticsPlayer1 = %TacticsPlayer1
## Reference to the TacticsPlayer2 node
@onready var player2: TacticsPlayer2 = %TacticsPlayer2

## Initializes the TacticsParticipant node
func _ready() -> void:
	# Initialize the service with necessary resources
	serv = TacticsParticipantService.new(res, camera, controls)
	# Set up the service with this node as context
	serv.setup(self)
	# Connect the skip_turn signal to the skip_turn method
	res.connect("called_skip_turn_player1", skip_turn_player1)
	res.connect("called_skip_turn_player2", skip_turn_player2)

## Performs the participant's action
##
## @param delta: Time elapsed since the last frame
## @param is_player: Whether the acting participant is the player
## @param parent: The parent node of the participant
func act(delta: float, is_player: bool, parent: Node3D) -> void:
	serv.act(delta, is_player, parent, self)


## Configures the participant with camera and control resources
##
## @param my_camera: The camera resource to use
## @param my_control: The control resource to use
func configure(my_camera: Resource, my_control: Resource) -> void:
	serv.configure(my_camera, my_control)


## Checks if the participant is properly configured
##
## @param parent: The parent node of the participant
## @return: Whether the participant is configured
func is_configured(parent: Node3D) -> bool:
	return serv.is_configured(parent)


## Checks if the participant can perform an action
##
## @param parent: The parent node of the participant
## @return: Whether the participant can act
func can_act(parent: Node3D) -> bool:
	return serv.can_act(parent)


## Resets the participant's turn
##
## @param parent: The parent node of the participant
func reset_turn(parent: Node3D) -> void:
	serv.reset_turn(parent)

func skip_turn_player1() -> void:
	serv.skip_turn_player1(player1)

func skip_turn_player2() -> void:
	serv.skip_turn_player2(player2)
