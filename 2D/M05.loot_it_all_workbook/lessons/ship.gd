extends Area2D


var max_speed := 1200.0
var velocity := Vector2(0, 0)
var steering_factor := 3.0

var ship_health := 90
var gem_count := 0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	get_node("DamageTimer").timeout.connect(_on_damage_timer_timeout)
	set_health(ship_health)
	set_gem_count(gem_count)

func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := max_speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	position += velocity * delta

	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()

func set_health(new_health: int) -> void:
	ship_health = new_health
	
	if ship_health > 100:
		ship_health = 100
		
	get_node("UI/HealthBar").value = ship_health
	
func set_gem_count(new_gem_count: int) -> void:
	gem_count = new_gem_count
	get_node("UI/GemCount").text = "x" + str(gem_count)

func _on_area_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group("gem"):
		set_gem_count(gem_count + 1)
		
	if area_that_entered.is_in_group("healing_item"):
		set_health(ship_health + 10)

func _on_damage_timer_timeout() -> void:
	ship_health -= 3
	get_node("UI/HealthBar").value = ship_health
