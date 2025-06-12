@tool
extends Button

#TODO: Fix color picker
@export_color_no_alpha var color : Color

func _ready() -> void:
	$ColorRect.color = color

func _on_button_up() -> void:
	Events.change_color(color)
