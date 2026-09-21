extends Node2D


@onready var _player_hurtbox: Area2D = %PlayerHurtbox


func _ready() -> void:
	_player_hurtbox.area_entered.connect(func (_other_area: Area2D) -> void:
		if _other_area is DefaultMob:
			PlayerUI.player_health -= 1
			_other_area.queue_free()
	)


	PlayerUI.health_depleted.connect(func() -> void:
		pass
	)
