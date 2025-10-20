extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered() -> void:
	pass
	
func _on_mouse_exited() -> void:
	pass
