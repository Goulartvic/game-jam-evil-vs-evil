class_name TacticsCameraPanningService
extends RefCounted
## Service class for handling camera panning in tactical view

var res: TacticsCameraResource


func _init(_res: TacticsCameraResource) -> void:
	res = _res


## Checks if WASD keys are being pressed
func is_pressing_wasd(input_dir: Vector2) -> bool:
	return input_dir != Vector2.ZERO


## Checks if the cursor is near the screen edge for edge panning
func is_cursor_near_edge(camera: TacticsCamera) -> bool:
	refresh_cam_viewport_size(camera)
	res.mouse_pos = camera.get_viewport().get_mouse_position()
	var panning: Dictionary = get_mouse_panning_values()
	
	return panning.h != 0 or panning.v != 0


## Handles panning with WASD keys
func wasd_pan(delta: float, camera: TacticsCamera, input_dir: Vector2) -> void:
	var h_val: float = float(input_dir.x)
	var v_val: float = float(-input_dir.y)
	
	do_pan(h_val, v_val, delta, camera)


## Handles panning when the cursor is near the screen edge
func edge_pan(delta: float, camera: TacticsCamera) -> void:
	refresh_cam_viewport_size(camera)
	var panning: Dictionary = get_mouse_panning_values()
	var h_val: float = panning.h
	var v_val: float = panning.v
	
	do_pan(h_val, v_val, delta, camera)


## Executes the panning movement
func do_pan(h: float, v: float, delta: float, camera: TacticsCamera) -> bool:
	if h != 0 or v != 0:
		res.panning_timer += delta
		if res.panning_timer >= res.PANNING_DELAY:
			camera.move_camera(h, v, false, delta)
			return true
	else:
		res.panning_timer = 0.0  # Reset the timer when not panning
	
	return false


## Updates the viewport size if it has changed
func refresh_cam_viewport_size(camera: TacticsCamera) -> bool:
	var vp_size: Vector2i = camera.get_viewport().size
	if vp_size != res.viewport_size:
		res.viewport_size = vp_size
		return true
	else:
		return false


## Calculates panning values based on mouse position
func get_mouse_panning_values() -> Dictionary:
	var h: float = 0.0
	var v: float = 0.0
	
	if res.mouse_pos.x <= res.border_pan_px_threshold:
		h = -1.0
	elif res.mouse_pos.x >= res.viewport_size.x - res.border_pan_px_threshold:
		h = 1.0
	if res.mouse_pos.y <= res.border_pan_px_threshold:
		v = 1.0
	elif res.mouse_pos.y >= res.viewport_size.y - res.border_pan_px_threshold:
		v = -1.0
	
	return {"h": h, "v": v}
