extends Control

@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var previous_button: Button = %PreviousButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var current_dialogue_item_index := 0

var expressions_dict := {
	 "happy": preload("res://assets/emotion_happy.png"),
	 "regular": preload("res://assets/emotion_regular.png"),
	 "sad": preload("res://assets/emotion_sad.png"),
}

var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions_dict["regular"],
		"text": "I'm learning about Arrays...",
	},
	
	{
		"expression": expressions_dict["sad"],
		"text": "...and it is a little bit complicated.",
	},
	
	{
		"expression": expressions_dict["happy"],
		"text": "Let's see if I got it right: an array is a list of values!",
	},
	
	{
		"expression": expressions_dict["regular"],
		"text": "Did I get it right? Did I?",
	},
	
	{
		"expression": expressions_dict["happy"],
		"text": "Hehe! Bye bye~!",
		
	},
	
]


func _ready() -> void:
	show_text()
	next_button.pressed.connect(_on_next_button_press)
	previous_button.pressed.connect(_on_previous_button_press)


func show_text() -> void:
	rich_text_label.visible_ratio = 0.0
	rich_text_label.text = dialogue_items[current_dialogue_item_index]["text"]
	expression.texture = dialogue_items[current_dialogue_item_index]["expression"]
	
	var tween := create_tween()
	var text_appearing_duration := 0.5
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	
	slide_in()


func slide_in() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	
	body.position.x = 200.0
	tween.tween_property(body, "position:x", 0.0, 0.5)
	
	body.modulate.a = 0.0
	tween.parallel().tween_property(body, "modulate:a", 1.0, 0.3)


func _on_next_button_press() -> void:
	current_dialogue_item_index += 1
	if current_dialogue_item_index > dialogue_items.size() - 1:
		current_dialogue_item_index = 0
	show_text()


func _on_previous_button_press() -> void:
	current_dialogue_item_index -= 1
	if current_dialogue_item_index < 0:
		current_dialogue_item_index = dialogue_items.size() - 1
	show_text()
