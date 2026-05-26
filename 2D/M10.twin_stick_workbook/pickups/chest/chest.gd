@tool
class_name Chest extends Area2D

var _player_node_reference: Node = null
var pickup = preload("res://pickups/pickup.tscn").instantiate()


@export var possible_chest_items: Array[Item] = []: set = set_items


@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player_node_reference = body
	)
	
	body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player_node_reference = null
	)


func set_items(items: Array[Item]) -> void:
	possible_chest_items = items
	update_configuration_warnings()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _player_node_reference != null:
		set_deferred("monitoring", false)
		_animation_player.play("open")
		spawn_chest_item()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if possible_chest_items.is_empty() == true:
		warnings.append("The chest has no items assigned. Please assign possible items for the chest to spawn in the inspector.")
	return warnings


func spawn_chest_item() -> void:
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2
	
	var jump_distance := randf_range(100.0, 120.0)
	var jump_height := jump_distance + (jump_distance / 2)
	var random_spawn_position = Vector2.RIGHT.rotated(randf_range(0, 2 * PI)) * jump_distance
	var tween := create_tween()
	
	pickup.item = possible_chest_items.pick_random()
	pickup.set_deferred("monitoring", false)
	pickup.scale = Vector2(0.1, 0.1)
	add_child(pickup)
	
	tween.set_parallel()
	tween.tween_property(pickup, "scale", Vector2(1.0, 1.0), FLIGHT_TIME)
	tween.tween_property(pickup, "position:x", random_spawn_position.x, FLIGHT_TIME)
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(pickup, "position:y", random_spawn_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(pickup, "position:y", random_spawn_position.y, HALF_FLIGHT_TIME)
	
	await tween.finished
	pickup.animation_player.play("idle")
	pickup.set_deferred("monitoring", true)
