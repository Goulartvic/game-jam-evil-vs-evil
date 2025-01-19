extends Container
## Controls the visibility and animation of controller hints
##
## This script manages the folding and unfolding of controller hints
## based on user input and mouse interactions.

## Duration of the folding/unfolding animation
const ANIMATION_DURATION: float = 0.3
## X-offset for the folded position of the hints
const FOLDED_OFFSET: float = -514.0

## Resource containing control-related data and configurations
var res: TacticsControlsResource = load("res://data/models/view/control/tactics/control.tres")
## Reference to the ControllerHints node
@onready var controller_hints: Control = $ControllerHints


## Initializes the node and sets up signal connections
func _ready() -> void:
	res.input_hints_folded = true
	update_hints_visibility(true)  # Force immediate update
	
	# Connect mouse signals
	controller_hints.mouse_entered.connect(on_mouse_entered)
	controller_hints.mouse_exited.connect(on_mouse_exited)


## Handles unhandled input events
##
## @param event: The input event to handle
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("controller_hints"):
		on_mouse_entered() # Unfold hints when action is pressed
	elif event.is_action_released("controller_hints"):
		on_mouse_exited() # Fold hints when action is released


## Handles mouse enter event
func on_mouse_entered() -> void:
	res.input_hints_folded = false
	update_hints_visibility() # Unfold hints


## Handles mouse exit event
func on_mouse_exited() -> void:
	res.input_hints_folded = true
	update_hints_visibility() # Fold hints


## Updates the visibility and position of the controller hints
##
## @param force_immediate: Whether to update immediately without animation
func update_hints_visibility(force_immediate: bool = false) -> void:
	var target_x: float = FOLDED_OFFSET if res.input_hints_folded else 0.0
	var target_alpha: float = 0.3 if res.input_hints_folded else 1.0
	
	if force_immediate:
		controller_hints.position.x = target_x # Set position immediately
		controller_hints.modulate.a = target_alpha # Set transparency immediately
	else:
		var tween: Tween = create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(controller_hints, "position:x", target_x, ANIMATION_DURATION)
		tween.tween_property(controller_hints, "modulate:a", target_alpha, ANIMATION_DURATION)
