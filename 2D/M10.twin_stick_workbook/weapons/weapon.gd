class_name Weapon extends Node2D

## Bullet scene to be used for weapon
@export var bullet_scene: PackedScene = preload("res://weapons/bullets/bullet.tscn")
## Max range of bullet based on weapon type
@export_range(0, 2000.0, 1) var max_range := 900.0
## Max speed of bullet based on weapon type
@export_range(0, 1000.0, 1) var max_bullet_speed := 1200.0
## Angle for deflection of bullets (spread) when firing weapon
@export_range(0, 360, 1, "radians_as_degrees") var random_bullet_deflection: float = PI / 12.0


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()


## Function to fire the weapon once
func shoot() -> void:
	# Add error check to inform if scene has been left empty in the inspector
	if bullet_scene == null:
		push_error("Bullet scene in inspector is null, scene required for weapon to function.")
		
	var bullet: Node = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.max_range = max_range
	bullet.speed = max_bullet_speed
	bullet.rotation += randf_range(-random_bullet_deflection / 2.0, random_bullet_deflection / 2.0)
	
