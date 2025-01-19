class_name TacticsControlsInputService
extends RefCounted
## Service class for managing input-related functionalities in the Tactics game.

## Reference to the TacticsControlsResource.
var controls: TacticsControlsResource
## Node for capturing mouse clicks.
var mouse_click_capture: Node


## Initializes the TacticsControlsInputService with necessary resources and nodes.
func _init(_controls: TacticsControlsResource, _mouse_click_capture: Node) -> void:
	controls = _controls
	mouse_click_capture = _mouse_click_capture


## Updates the mouse mode based on whether a joystick is being used.
func update_mouse_mode() -> void:
	Input.set_mouse_mode(int(controls.is_joystick))


## Handles input events and updates the joystick status.
func handle_input(event: InputEvent) -> void:
	controls.is_joystick = event is InputEventJoypadButton or event is InputEventJoypadMotion


## Gets the 3D position of the mouse in the game world.
## Returns null if hovering over a UI element or if mouse_click_capture is not set.
func get_3d_canvas_mouse_position(collision_mask: int, ctrl: TacticsControls) -> Object:
	if is_mouse_hovering_ui_elem(ctrl):
		return null
	
	if mouse_click_capture:
		return mouse_click_capture.project_mouse_position(collision_mask, controls.is_joystick)
	else:
		push_error("MouseClickCapture node not found")
		return null


## Checks if the mouse is hovering over a UI element.
## Returns true if the mouse is over any of the specified UI elements.
func is_mouse_hovering_ui_elem(
		ctrl: TacticsControls, elm: Array[String] = TacticsConfig.ui_elem) -> bool:
	for e: String in elm:
		if ctrl.get_node(e).visible:
			match e:
				"%Actions":
					for action: Button in ctrl.get_node(e).get_children():
						if action.get_global_rect().has_point(ctrl.get_viewport().get_mouse_position()): 
							return true
				"%Hints":
					for hint: TextureRect in ctrl.get_node(e).get_children():
						if hint.get_global_rect().has_point(ctrl.get_viewport().get_mouse_position()): 
							return true
	return false
