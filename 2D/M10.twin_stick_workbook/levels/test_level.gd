extends Node2D

@onready var _end_menu: Control = %EndMenu
@onready var _teleporter: Area2D = %EndTeleporter
@onready var background_music: AudioStreamPlayer = $BackgroundMusic


func _ready() -> void:
	background_music.play()
	
	_teleporter.body_entered.connect(func(body: Node) -> void:
		if body is Player:
			_end_menu.open()
	)
	
	
	
