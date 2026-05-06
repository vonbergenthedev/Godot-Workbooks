extends Node2D

@export var bullet_scene: PackedScene = null
@export_range(0.0, 2000.0) var max_range := 2000.0
@export_range(0.0, 3000.0) var max_bullet_speed := 1500.0
@export_range(0.0, 15.0, 0.5, "radians_as_degrees") var shot_angle := 0.0


func _process(_delta: float) -> void:
		if Input.is_action_just_pressed("shoot"):
			var bullet = bullet_scene.instantiate()
			
			get_tree().current_scene.add_child(bullet)
		
			bullet.global_rotation = global_rotation
			bullet.global_position = global_position
			bullet.max_range = max_range
			bullet.speed = max_bullet_speed
			bullet.rotation += randf_range(-shot_angle, shot_angle)
