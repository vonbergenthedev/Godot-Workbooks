extends Node2D

@onready var default_mob: DefaultMob = $DefaultMob

func _physics_process(_delta: float) -> void:
	if DefaultMob && default_mob != null:
		$DefaultMob.global_position = get_global_mouse_position()
