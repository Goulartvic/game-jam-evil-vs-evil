class_name TacticsTileRaycast
extends Node3D
## Handles raycasting operations for TacticsTile.
##
## This class is responsible for detecting neighboring tiles and objects above the tile.
## It is typically instantiated as a child of TacticsTile.


#region: --- Methods ---
## Returns all the neighbouring tiles within a given height range.
## [param height] The maximum height difference to consider for neighbors.
## [returns] An array of neighboring Node3D objects (typically TacticsTiles).
func get_all_neighbors(height: float) -> Array[Node3D]:
	var neighbors: Array[Node3D] = []
	
	for ray: RayCast3D in $Neighbors.get_children() as Array[RayCast3D]:
		var obj: Node3D = ray.get_collider() # Get the object hit by the ray
		
		# Check if object exists and is within the specified height range
		if (obj and abs(obj.global_position.y - get_parent().global_position.y) 
				<= height):
			neighbors.append(obj) # Add the object to neighbors list
			
	return neighbors


## Returns the object directly above the tile.
## [returns] The object above the tile, or null if none found.
func get_object_above() -> Object:
	return $Above.get_collider() # Return object hit by the upward-facing ray
#endregion
