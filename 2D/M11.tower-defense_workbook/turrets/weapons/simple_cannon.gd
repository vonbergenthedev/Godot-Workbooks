class_name SimpleCannon extends Weapon


func _physics_process(_delta: float) -> void:
	$Mob.global_position = get_global_mouse_position()
	var mobs_in_range := _area_2d.get_overlapping_areas()
	if not mobs_in_range.is_empty():
		var target: Area2D = mobs_in_range.front()
		look_at(target.global_position)
