extends Control


@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var previous_button: Button = %PreviousButton


var current_dialogue_item_index := 0
var dialogue_items: Array[String] = [
	"I'm learning about Arrays...",
	"...and it is a little bit complicated.",
	"Let's see if I got it right: an array is a list of values!",
	"Did I get it right? Did I?",
	"Hehe! Bye bye~!",
]


func _ready() -> void:
	rich_text_label.text = dialogue_items[current_dialogue_item_index]
	next_button.pressed.connect(_on_next_button_press)
	previous_button.pressed.connect(_on_previous_button_press)


func show_text() -> void:
	rich_text_label.text = dialogue_items[current_dialogue_item_index]


func _on_next_button_press() -> void:
	if current_dialogue_item_index < dialogue_items.size() - 1:
		current_dialogue_item_index += 1
		show_text()


func _on_previous_button_press() -> void:
	if current_dialogue_item_index > 0:
		current_dialogue_item_index -= 1
		show_text()
