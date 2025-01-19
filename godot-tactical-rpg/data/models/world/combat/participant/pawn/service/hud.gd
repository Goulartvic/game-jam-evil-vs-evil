class_name TacticsPawnHudService
extends RefCounted
## Service class for managing the HUD (Heads-Up Display) of a pawn in the tactics game


## Updates the health display of the pawn's character UI
##
## @param pawn: The TacticsPawn whose health display needs to be updated
func update_character_health(pawn: TacticsPawn) -> void:
	var _health_label: Label3D = pawn.get_node("Character/CharacterUI/HealthLabel")
	_health_label.text = str(pawn.stats.curr_health) + "/" + str(pawn.stats.max_health)


## Applies a tint to the pawn's sprite when it's unable to act
##
## @param pawn: The TacticsPawn to apply the tint to
func tint_when_unable_to_act(pawn: TacticsPawn) -> void:
	var _char_node: TacticsPawnSprite = pawn.get_node("Character")
	_char_node.modulate = Color(0.5, 0.5, 0.5) if not pawn.can_act() else Color(1, 1, 1)
