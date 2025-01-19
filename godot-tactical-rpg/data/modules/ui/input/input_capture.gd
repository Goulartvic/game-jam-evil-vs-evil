class_name InputCapture
extends Node3D
## Handles input capture and mouse position projection in 3D space

#region: --- Methods ---
## Projects the mouse position onto the 3D world and returns the collided object
##
## This method casts a ray from the camera through the mouse pointer (or screen center for joystick)
## and returns the first object it collides with.
##
## @param collision_mask: The collision mask to use for the ray cast
## @param is_joystick: Whether the input is from a joystick (uses screen center) or mouse
## @return: The object that the ray collided with, or null if no collision
func project_mouse_position(collision_mask: int, is_joystick: bool) -> Object:
	var ray_length: int = 1_000_000 # Maximum length of the ray cast
	var camera: Camera3D = get_viewport().get_camera_3d() # Get the current 3D camera
	var mouse_pointer_origin: Vector2 = get_viewport().get_mouse_position() if not is_joystick else get_viewport().size / 2 # Get mouse or screen center position
	var from: Vector3 = camera.project_ray_origin(mouse_pointer_origin) # Start point of the ray
	var to: Vector3 = from + camera.project_ray_normal(mouse_pointer_origin) * ray_length # End point of the ray
	var ray_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to, collision_mask, []) # Create ray query parameters
	return get_world_3d().direct_space_state.intersect_ray(ray_query).get("collider") # Perform ray cast and return collider
#endregion
