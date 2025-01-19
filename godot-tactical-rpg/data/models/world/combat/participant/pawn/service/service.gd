class_name TacticsPawnService
extends RefCounted
## Service class for managing pawn operations in the tactics game

## Service for handling pawn movement
var movement: TacticsPawnMovementService
## Service for handling pawn combat
var combat: TacticsPawnCombatService
## Service for handling pawn animations
var animation: TacticsPawnAnimationService
## Service for handling pawn HUD operations
var ui: TacticsPawnHudService
## Reference to the pawn's sprite
var character: TacticsPawnSprite


## Initializes the TacticsPawnService and its sub-services
func _init() -> void:
	movement = TacticsPawnMovementService.new()
	combat = TacticsPawnCombatService.new()
	animation = TacticsPawnAnimationService.new()
	ui = TacticsPawnHudService.new()


## Sets up the pawn service, particularly the animation service
##
## @param pawn: The TacticsPawn to set up
func setup(pawn: TacticsPawn) -> void:
	animation.setup(pawn)


## Processes pawn-related operations every frame
##
## @param pawn: The TacticsPawn to process
## @param delta: Time elapsed since the last frame
func process(pawn: TacticsPawn, delta: float) -> void:
	pawn.get_node("Character").rotate_sprite(pawn.global_basis)
	movement.move_along_path(pawn, delta)
	animation.start_animator(pawn)
	ui.tint_when_unable_to_act(pawn)
	ui.update_character_health(pawn)


## Initiates an attack on a target pawn
##
## @param pawn: The attacking TacticsPawn
## @param target_pawn: The TacticsPawn being attacked
## @param delta: Time elapsed since the last frame
## @return: Whether the attack was successful
func attack_target_pawn(pawn: TacticsPawn, target_pawn: TacticsPawn, delta: float) -> bool:
	return combat.attack_target_pawn(pawn, target_pawn, delta)
