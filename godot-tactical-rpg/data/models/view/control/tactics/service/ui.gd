class_name TacticsUIService
extends RefCounted
## Service class for managing UI-related functionalities in the Tactics game.

## Reference to the TacticsControlsResource.
var controls: TacticsControlsResource


## Initializes the TacticsUIService with the necessary controls resource.
func _init(_controls: TacticsControlsResource) -> void:
	controls = _controls


## Updates the controller hints based on the current input device.
func update_controller_hints(ctrl: TacticsControls) -> void:
	if controls.is_joystick:
		ctrl.get_node("%ControllerHints").texture = ctrl.layout_xbox # Set Xbox layout if using joystick
	else:
		ctrl.get_node("%ControllerHints").texture = ctrl.layout_pc # Set PC layout otherwise


## Sets the visibility of the actions menu and updates action button states.
func set_actions_menu_visibility(v: bool, p: TacticsPawn, ctrl: TacticsControls) -> void:
	if not ctrl.get_node("HBox/Actions").visible:
		ctrl.get_node("HBox/Actions/Move").grab_focus() # Focus on Move action if menu wasn't visible
	
	ctrl.get_node("HBox/Actions").visible = v and p.can_act() # Show menu if pawn can act
	
	if not p:
		return # Exit if no pawn is provided
	
	# Update action button states based on pawn's capabilities
	ctrl.get_node("HBox/Actions/Move").disabled = not p.res.can_move
	ctrl.get_node("HBox/Actions/Attack").disabled = not p.res.can_attack
