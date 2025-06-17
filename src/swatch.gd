@tool
extends Button

@export_color_no_alpha var color : Color
@export var reference : Node2D
@onready var body: Sprite2D = $"../../../Pal_Template/Body"

func _ready() -> void:
	$ColorRect.color = color

func _on_button_up() -> void:
	if not reference: return
	reference.update_color(color)
