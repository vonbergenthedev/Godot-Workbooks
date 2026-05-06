@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item


@onready var _sprite_2d: Sprite2D = $Sprite2D
@onready var _audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	set_item(item)
	
	animation_player.play("idle")
	
	body_entered.connect(func (body: Node2D) -> void:
		if body is Player:
			if item is HealingItem:
				if body.health < body.max_health:
					item.use(body)
					animation_player.play("destroy_pickup")
					set_deferred("monitoring", false)
					_audio_stream_player_2d.play()
					animation_player.animation_finished.connect(func (_animation_name: String) -> void:
						queue_free()
					)
	)


func set_item(value: Item) -> void:
	item = value
	update_configuration_warnings()
	if _sprite_2d != null:
		_sprite_2d.texture = item.sprite_texture
	if _audio_stream_player_2d != null:
		_audio_stream_player_2d.stream = item.stream


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if item == null:
		warnings.append("The pickup has no item assigned. Please assign an item to the pickup in the inspector.")
	return warnings
