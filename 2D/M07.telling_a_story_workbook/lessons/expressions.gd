extends Control


@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var button_sophia: Button = %ButtonSophia
@onready var button_pink: Button = %ButtonPink
@onready var button_regular: Button = %ButtonRegular
@onready var button_sad: Button = %ButtonSad
@onready var button_happy: Button = %ButtonHappy


var bodies_dict := {
	"sophia": preload("res://assets/sophia.png"),
	"pink": preload("res://assets/pink.png"),
}


var expressions_dict := {
	 "happy": preload("res://assets/emotion_happy.png"),
	 "regular": preload("res://assets/emotion_regular.png"),
	 "sad": preload("res://assets/emotion_sad.png"),
}


func _ready() -> void:
	body.texture = bodies_dict["pink"]
	expression.texture = expressions_dict["happy"]
	
	button_sophia.pressed.connect(func() -> void: body.texture = bodies_dict["sophia"])
	button_pink.pressed.connect(func() -> void: body.texture = bodies_dict["pink"])
	button_regular.pressed.connect(func() -> void: expression.texture = expressions_dict["regular"])
	button_sad.pressed.connect(func() -> void: expression.texture = expressions_dict["sad"])
	button_happy.pressed.connect(func() -> void: expression.texture = expressions_dict["happy"])
	
