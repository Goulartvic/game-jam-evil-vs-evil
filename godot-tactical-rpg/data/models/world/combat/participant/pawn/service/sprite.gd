class_name TacticsPawnSprite
extends Sprite3D
## Handles the visual representation and animation of a pawn in the tactics game

## Animation state machine playback controller
var animator: AnimationNodeStateMachinePlayback = null
## Current frame of the sprite animation
var curr_frame: int = 0

## Reference to the AnimationTree node
@onready var animation_tree: AnimationTree = $AnimationTree
## Reference to the Label3D node displaying the pawn's name
@onready var character_ui_name_label: Label3D = $CharacterUI/NameLabel


## Sets up the pawn sprite with the given stats and expertise
##
## @param stats: The Stats resource containing pawn data
## @param expertise: The pawn's expertise (class or type)
func setup(stats: Stats, expertise: String) -> void:
	var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
	if playback is AnimationNodeStateMachinePlayback:
		animator = playback
	else:
		push_error("Expected AnimationNodeStateMachinePlayback, but got " + str(typeof(playback)))
		return
	
	animator.start("IDLE")
	animation_tree.active = true
	texture = load(stats.sprite) as Texture2D
	character_ui_name_label.text = stats.override_name if stats.override_name else expertise


## Starts the appropriate animation based on the pawn's movement and state
##
## @param move_direction: The direction the pawn is moving in
## @param is_jumping: Whether the pawn is currently jumping
func start_animator(move_direction: Vector3, is_jumping: bool) -> void:
	if move_direction == Vector3.ZERO:
		animator.travel("IDLE")
	elif is_jumping:
		animator.travel("JUMP")


## Rotates the sprite to face the camera and selects the appropriate frame
##
## @param _global_basis: The global basis of the pawn
func rotate_sprite(_global_basis: Basis) -> void:
	# Get forward vector of the camera (looking down the negative Z-axis)
	var _camera_forward: Vector3 = -get_viewport().get_camera_3d().global_basis.z
	# Measure how much the pawn faces towards or away from camera
	var _scalar: float = _global_basis.z.dot(_camera_forward)
	# Determine if the sprite should be flipped horizontally
	flip_h = _global_basis.x.dot(_camera_forward) > 0
	# Select appropriate sprite frame based on pawn orientation relative to camera
	if _scalar < -0.306: # Pawn is facing away from camera, use base "back" frame
		frame = curr_frame
	elif _scalar > 0.306: # Facing towards camera, use "front" view
		frame = curr_frame + 1 * TacticsPawnResource.ANIMATION_FRAMES
	# Note: If -0.306 <= scalar <= 0.306, the frame remains unchanged


## Adjusts the pawn's position to the center of its current tile
##
## @param pawn: The TacticsPawn to adjust
## @return: Whether the adjustment was successful
func adjust_to_center(pawn: TacticsPawn) -> bool:
	if pawn.get_tile() and not pawn.res.is_moving:
		pawn.global_position = pawn.get_tile().global_position
		return true
	return false
