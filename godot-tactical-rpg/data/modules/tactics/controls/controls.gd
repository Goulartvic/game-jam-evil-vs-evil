class_name TacticsControls
extends Control
## Handles UI elements and player controls for the Tactics systems
## 
## Resource Interface: [TacticsControlsResource] -- Service: [TacticsControlsService]

#region: --- Props ---
## Resource containing control-related data and settings
@export var controls: TacticsControlsResource = load("res://data/models/view/control/tactics/control.tres")
## Resource containing camera-related data and settings
@export var t_cam: TacticsCameraResource = load("res://data/models/view/camera/tactics/camera.tres")
## Resource containing participant-related data and settings
@export var participant: TacticsParticipantResource = load("res://data/models/world/combat/participant/participant.tres")
## Resource containing arena-related data and settings
@export var arena: TacticsArenaResource = load("res://data/models/world/combat/arena/arena.tres")

## Currently selected pawn
var curr_pawn: TacticsPawn = null
## Service handling control logic
var serv: TacticsControlsService

## Texture for Xbox controller layout
@onready var layout_xbox: Texture2D = load("res://assets/textures/ui/labels/controls-ui-xbox.png")
## Texture for PC controls layout
@onready var layout_pc: Texture2D = load("res://assets/textures/ui/labels/controls-ui.png")
## Node for capturing mouse clicks
@onready var mouse_click_capture: InputCapture = $MouseClickCapture
#endregion

#region: --- Processing ---
func _ready() -> void:
	# Initialize the service with necessary resources
	serv = TacticsControlsService.new(controls, t_cam, participant, arena, mouse_click_capture)
	serv.setup(self)
	
	# Connect action buttons to their respective methods
	for action: String in controls.actions.keys():
		var str_name: StringName = controls.actions[action]
		get_act(action).connect("pressed", Callable(self, str_name))

func _physics_process(delta: float) -> void:
	# Handle physics-based processing
	serv.physics_process(delta, self)

func _input(event: InputEvent) -> void:
	# Handle input events
	serv.handle_input(event)
#endregion

#region: --- Methods ---
## Sets the cursor shape to 'move'
func set_cursor_shape_to_move() -> void:
	CursorService.set_cursor_shape_to_move()


## Sets the cursor shape to 'arrow'
func set_cursor_shape_to_arrow() -> void:
	CursorService.set_cursor_shape_to_arrow()


## Moves the camera based on input
func move_camera(delta: float) -> void:
	serv.move_camera(delta)


## Handles camera rotation inputs
func camera_rotation_inputs(delta: float) -> void:
	serv.camera_rotation_inputs(delta)


## Retrieves an action button node
func get_act(action: String = "") -> Button:
	if action == "": 
		return %Actions
	return %Actions.get_node(action)


## Checks if the mouse is hovering over a UI element
func is_mouse_hovering_ui_elem() -> bool:
	return serv.is_mouse_hovering_ui_elem(self)


## Sets the visibility of the actions menu
func set_actions_menu_visibility(v: bool, p: TacticsPawn) -> void:
	serv.set_actions_menu_visibility(v, p, self)


## Gets the 3D position of the mouse in the game world
func get_3d_canvas_mouse_position(collision_mask: int) -> Object:
	return serv.get_3d_canvas_mouse_position(collision_mask, self)


## Selects a pawn for the player
func select_pawn(player: TacticsPlayer) -> void:
	serv.select_pawn(player, self)


## Initiates the process of selecting a new location for the pawn
func select_new_location() -> void:
	serv.select_new_location(self)


## Initiates the process of selecting a pawn to attack
func select_pawn_to_attack() -> void:
	serv.select_pawn_to_attack(self)


## Handles the player's intention to move
func _player_wants_to_move() -> void:
	serv.player_wants_to_move()


## Handles the player's intention to cancel an action
func _player_wants_to_cancel() -> void:
	serv.player_wants_to_cancel()


## Handles the player's intention to wait
func _player_wants_to_wait() -> void:
	serv.player_wants_to_wait()


## Handles the player's intention to skip their turn
func _player_wants_to_skip_turn() -> void:
	serv.player_wants_to_skip_turn()


## Handles the player's intention to attack
func _player_wants_to_attack() -> void:
	serv.player_wants_to_attack()
#endregion
