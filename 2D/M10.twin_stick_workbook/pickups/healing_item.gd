class_name HealingItem extends Item


@export var healing_amount := 2


func use(player: Player) -> void:
	player.health += healing_amount
