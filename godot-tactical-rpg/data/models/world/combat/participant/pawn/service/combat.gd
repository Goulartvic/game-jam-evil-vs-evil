class_name TacticsPawnCombatService
extends RefCounted
## Service class for managing combat actions of pawns in the tactics game


## Executes an attack from one pawn to another
##
## @param pawn: The attacking TacticsPawn
## @param target_pawn: The TacticsPawn being attacked
## @param delta: Time elapsed since the last frame
## @return: Whether the attack was completed
func attack_target_pawn(pawn: TacticsPawn, target_pawn: TacticsPawn, delta: float) -> bool:
	# Make the attacking pawn face the target
	pawn.serv.movement.look_at_direction(pawn, target_pawn.global_position - pawn.global_position)
	
	# Check if the pawn can attack and enough time has passed for the attack animation
	if pawn.res.can_attack and pawn.res.wait_delay > TacticsPawnResource.MIN_TIME_FOR_ATTACK / 4.0:
		# Apply damage to the target pawn
		target_pawn.stats.apply_to_curr_health(-pawn.stats.attack_power)
		
		# Print debug information if debug mode is enabled
		if DebugLog.debug_enabled:
			print_rich("[color=pink]Attacked ", target_pawn, " for ", pawn.stats.attack_power, " damage.[/color]")
		
		# Set the attacking state to false
		pawn.res.set_attacking(false)
	
	# If the minimum time for attack hasn't passed, increment the wait delay
	if pawn.res.wait_delay < TacticsPawnResource.MIN_TIME_FOR_ATTACK:
		pawn.res.wait_delay += delta
		return false
	
	# Reset the wait delay and return true to indicate the attack is complete
	pawn.res.wait_delay = 0.0
	return true
