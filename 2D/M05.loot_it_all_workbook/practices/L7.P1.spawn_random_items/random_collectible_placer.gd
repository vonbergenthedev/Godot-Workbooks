extends Node2D

var collectible_scenes := [
	preload("coin.tscn"),
	preload("energy_pack.tscn"),
]


func _ready() -> void:
	get_node("Timer").timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var screen_size := get_viewport_rect().size
	
	var random_position := Vector2(0.0, 0.0)
	random_position.x = randf_range(0.0, screen_size.x)
	random_position.y = randf_range(0.0, screen_size.y)
	
	var random_collectable_scene : PackedScene = collectible_scenes.pick_random()
	var random_collectable_instance := random_collectable_scene.instantiate()
	# random_collectable_instance.position = random_position
	
	add_child(random_collectable_instance)
