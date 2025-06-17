extends Sprite2D

@export_color_no_alpha var color: Color

func _ready():
	update_color(color)

func _on_swatch_clicked(p_color: Color):
	update_color(p_color)

func update_color(p_color: Color):
	var shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://src/pal_color.gdshader")
	shader_material.set_shader_parameter("modulate_color", p_color)
	material = shader_material
	color = p_color
