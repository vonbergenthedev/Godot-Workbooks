extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _process(delta: float) -> void:
	pass
	
func _on_area_entered(area_that_entered: Area2D) -> void:
	print("Entered Healthpack Area")
	queue_free()
