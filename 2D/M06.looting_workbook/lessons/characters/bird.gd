extends Node2D

@onready var bird_sprite: Sprite2D = $BirdSprite
@onready var shadow: Sprite2D = $Shadow
@onready var jump_timer: Timer = $JumpTimer


func _ready() -> void:
	jump_timer.wait_time = randf_range(1.0, 2.0)
	jump_timer.one_shot = true
	jump_timer.timeout.connect(_on_timeout)
	jump_timer.start()


func _on_timeout() -> void:
	var random_direction := Vector2(1.0, 0.0).rotated(randf() * 2.0 * PI) 
	var land_position := random_direction * randf_range(0.0, 30.0)
	var jump_duration := 0.25
	var jump_height := 16
	
	var tween := create_tween().set_parallel()
	if bird_sprite.flip_h == false and land_position.x > bird_sprite.position.x:
		tween.tween_property(bird_sprite, "position:x", land_position.x, jump_duration)
		tween.tween_property(shadow, "position", Vector2(land_position.x + 7, land_position.y + 17), jump_duration)
		bird_sprite.flip_h = true
	else:
		tween.tween_property(bird_sprite, "position:x", land_position.x, jump_duration)
		tween.tween_property(shadow, "position", Vector2(land_position.x - 7, land_position.y + 17), jump_duration)
		bird_sprite.flip_h = false
		
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(bird_sprite, 'position:y', land_position.y - jump_height, jump_duration / 2.0)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(bird_sprite, 'position:y', land_position.y, jump_duration / 2.0)

	jump_timer.wait_time = randf_range(1.0, 2.0)
	tween.finished.connect(jump_timer.start)
