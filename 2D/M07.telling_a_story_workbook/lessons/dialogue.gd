extends Control


@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var previous_button: Button = %PreviousButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var current_dialogue_item_index := 0
var dialogue_items: Array[String] = [
	"I'm learning about Arrays...",
	"...and it is a little bit complicated.",
	"Let's see if I got it right: an array is a list of values!",
	"Did I get it right? Did I?",
	"Hehe! Bye bye~!",
]


func _ready() -> void:
	show_text()
	next_button.pressed.connect(_on_next_button_press)
	previous_button.pressed.connect(_on_previous_button_press)


func show_text() -> void:
	rich_text_label.visible_ratio = 0.0
	rich_text_label.text = dialogue_items[current_dialogue_item_index]
	
	var tween := create_tween()
	var text_appearing_duration := 0.5
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)


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
