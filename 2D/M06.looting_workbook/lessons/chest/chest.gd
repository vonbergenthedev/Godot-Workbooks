extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var possible_items: Array[PackedScene] = []

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	
	set_outline_thickness(3.0)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)

func open() -> void:
	animation_player.play("open")
	input_pickable = false
	
	if possible_items.is_empty():
		return
		
	_spawn_random_item()

func _on_mouse_entered() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 3.0, 6.0, 0.08)
	
func _on_mouse_exited() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 6.0, 3.0, 0.08)

func _input_event(viewport: Node, event: InputEvent, shape_index: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_pressed()
	)
	
	if event_is_mouse_click:
		open()

func _spawn_random_item() -> void:
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0
	
	for i in range(randi_range(1, 3)):
		#Instantiate a random loot item scene and calulate a landing position away from chest sprite
		# origin
		var loot_item: Area2D = possible_items.pick_random().instantiate()
		var random_angle := randf_range(0.0, 2.0 * PI)
		var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
		var random_distance := randf_range(60.0, 120.0)
		var land_position := random_direction * random_distance
		
		#Add loot item scene to dungeon scene
		add_child(loot_item)
		
		#Tween to scale loot item from 25% to 100% as it moves to it's x position
		var tween := create_tween()
		tween.set_parallel()
		loot_item.scale = Vector2(0.25, 0.25)
		tween.tween_property(loot_item, "scale", Vector2(1.0, 1.0), HALF_FLIGHT_TIME)
		tween.tween_property(loot_item, "position:x", land_position.x, FLIGHT_TIME)
		
		#Tween to animate rise and fall using tweens to reach the peak of y value - a random jump
		# height and
		tween = create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_OUT)
		var jump_height := randf_range(60.0, 120.0)
		tween.tween_property(loot_item, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(loot_item, "position:y", land_position.y, HALF_FLIGHT_TIME)
		
