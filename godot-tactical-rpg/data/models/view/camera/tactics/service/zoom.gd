class_name TacticsCameraZoomService
extends RefCounted
## Service class for handling camera zoom in tactical view

const DELTA_SMOOTHING: int = 10

var res: TacticsCameraResource


func _init(_res: TacticsCameraResource) -> void:
	res = _res


## Adjust the target FOV for zooming
func zoom_camera(zoom_increment: float) -> void:
	res.target_fov = clamp(res.target_fov + zoom_increment, res.min_zoom, res.max_zoom)


## Smoothly interpolate current FOV to target FOV
func apply_zoom_smoothing(camera: TacticsCamera, delta: float) -> void:
	if res.current_fov != res.target_fov:
		res.current_fov = lerp(res.current_fov, res.target_fov, (res.zoom_smoothness * DELTA_SMOOTHING) * delta)
		camera.cam_node.fov = res.current_fov


## Reset camera zoom to default value
func reset_cam_zoom(cam_node: Camera3D, camera: TacticsCamera) -> void:
	res.target_fov = TacticsConfig.view.default_t_cam_zoom
	
	var tween: Tween = camera.create_tween()
	tween.tween_property(cam_node, "fov", res.target_fov, res.zoom_duration).set_trans(Tween.TRANS_SINE)
