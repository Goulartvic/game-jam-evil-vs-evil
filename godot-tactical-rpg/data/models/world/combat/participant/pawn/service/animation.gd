class_name TacticsPawnAnimationService
extends RefCounted
## Service class for managing animations of pawns in the tactics game


## Sets up the pawn's character animations
##
## @param pawn: The TacticsPawn to set up animations for
func setup(pawn: TacticsPawn) -> void:
	pawn.get_node("Character").setup(pawn.stats, pawn.expertise)


## Starts the appropriate animation for the pawn based on its current state
##
## @param pawn: The TacticsPawn to animate
func start_animator(pawn: TacticsPawn) -> void:
	pawn.get_node("Character").start_animator(pawn.res.move_direction, pawn.res.is_jumping)
