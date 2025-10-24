extends Area2D

@onready var flame: Sprite2D = $Flame

func _ready() -> void:
	# This parameter of the shader material gives each flame a slightly different look and randomized animation.
	flame.material.set("shader_parameter/offset", global_position * 0.1)
	input_event.connect(_on_input_event)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_pressed()
	)
	
	if event_is_mouse_click:
		var tween := create_tween()
		
		if flame.visible:
			tween.tween_property(flame, "scale", Vector2(0.0, 0.0), 0.25)
			await tween.finished
			flame.visible = false
		else:
			flame.visible = true
			tween.tween_property(flame, "scale", Vector2(0.28, 0.28), 0.25)
		
