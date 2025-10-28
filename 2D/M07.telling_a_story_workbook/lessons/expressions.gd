extends Control


@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var row_bodies: HBoxContainer = $VBoxContainer/RowBodies
@onready var row_expressions: HBoxContainer = $VBoxContainer/RowExpressions


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
	body.texture = bodies_dict["sophia"]
	expression.texture = expressions_dict["happy"]
	
	create_buttons()
	

func create_buttons() -> void:
	
	for current_body: String in bodies_dict:
		var button := Button.new()
		button.text = current_body.capitalize()
		
		button.pressed.connect(func() -> void:
			body.texture = bodies_dict[current_body]
		)

		row_bodies.add_child(button)
		
	for current_expression in expressions_dict:
		var button := Button.new()
		button.text = current_expression.capitalize()
		
		button.pressed.connect(func() -> void:
			expression.texture = expressions_dict[current_expression]
		)
		
		row_expressions.add_child(button)
