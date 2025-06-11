extends Sprite2D

func _ready():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://path_to_your_shader.gdshader")
	shader_material.set_shader_parameter("modulate_color", Color(1, 0, 0, 1)) # Red color
	self.material = shader_material
