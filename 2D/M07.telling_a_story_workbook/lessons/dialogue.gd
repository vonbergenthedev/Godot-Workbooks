extends Control

@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var previous_button: Button = %PreviousButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var current_dialogue_item_index := 0

var bodies_dict := {
	"pink": preload("res://assets/pink.png"),
	"sophia": preload("res://assets/sophia.png"),
}

var expressions_dict := {
	 "happy": preload("res://assets/emotion_happy.png"),
	 "regular": preload("res://assets/emotion_regular.png"),
	 "sad": preload("res://assets/emotion_sad.png"),
}

var voices_dict := {
	"voice_1": preload("res://assets/talking_synth.ogg"),
	"voice_2": preload("res://assets/talking_synth_alternate.ogg"),
}


var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions_dict["regular"],
		"text": "I've been studying [i]arrays [b]and[/b] dictionaries[/i] lately.",
		"body": bodies_dict["sophia"],
		"voice": voices_dict["voice_1"],
	},
	{
		"expression": expressions_dict["regular"],
		"text": "[wave]Oh, nice.[/wave] How has it been going?",
		"body": bodies_dict["pink"],
		"voice": voices_dict["voice_2"],
	},
	{
		"expression": expressions_dict["sad"],
		"text": "Well... it's a little [i]complicated![/i]",
		"body": bodies_dict["sophia"],
		"voice": voices_dict["voice_1"],
	},
	{
		"expression": expressions_dict["sad"],
		"text": "[tornado val=5.0]Oh![/tornado]",
		"body": bodies_dict["pink"],
		"voice": voices_dict["voice_2"],
	},
	{
		"expression": expressions_dict["regular"],
		"text": "It sure takes time to click at first.",
		"body": bodies_dict["pink"],
		"voice": voices_dict["voice_2"],
	},
	{
		"expression": expressions_dict["happy"],
		"text": "If you keep at it, eventually, you'll get the hang of it!",
		"body": bodies_dict["pink"],
		"voice": voices_dict["voice_2"],
	},
	{
		"expression": expressions_dict["regular"],
		"text": "Mhhh... I [u]see[/u]. I'll keep at it, then.",
		"body": bodies_dict["sophia"],
		"voice": voices_dict["voice_1"],
	},
	{
		"expression": expressions_dict["happy"],
		"text": "[rainbow val=0.9]Thanks for the encouragement.[/rainbow] Time to LEARN!!!",
		"body": bodies_dict["sophia"],
		"voice": voices_dict["voice_1"],
	},
]


func _ready() -> void:
	show_text()
	next_button.pressed.connect(_on_next_button_press)
	previous_button.pressed.connect(_on_previous_button_press)


func show_text() -> void:
	rich_text_label.visible_ratio = 0.0
	body.texture = dialogue_items[current_dialogue_item_index]["body"]
	expression.texture = dialogue_items[current_dialogue_item_index]["expression"]
	rich_text_label.text = dialogue_items[current_dialogue_item_index]["text"]
	audio_stream_player.stream = dialogue_items[current_dialogue_item_index]["voice"]
	
	var tween := create_tween()
	var text_appearing_duration: float = rich_text_label.get_parsed_text().length() / 45.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	
	next_button.disabled = true
	tween.finished.connect(
		func() -> void:
			next_button.disabled = false
	)
	
	previous_button.disabled = true
	tween.finished.connect(
		func() -> void:
			previous_button.disabled = false
	)
	
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
