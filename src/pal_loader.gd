extends Node2D

var PAL = "res://pals/pal-44558.json"
var FOLDER: String = "res://assets/"
var scene = preload("res://src/pal_template.tscn")
var pal_scene

func _ready() -> void:
	add_pal_from_json(PAL)

func add_pal_from_json(json_string: String):
	var pal_values = load_json_file(PAL)
	print_debug(pal_values["param_body"])
	pal_scene = scene.instantiate()
	add_child(pal_scene)
	set_pal_parameters(
		pal_scene, # referenced scene
		Color.BLUE_VIOLET, # body color
		0, # head
		pal_values["param_eyes"], # eyes
		1, # mouth
		0, # drip
		0  # tail
		)

func load_json_file(load_path: String):
	var file_access := FileAccess.open(load_path, FileAccess.READ)
	if not file_access:
		print_debug("An error occured while saving: ", FileAccess.get_open_error())
		return null
	var output = file_access.get_line()
	file_access.close()
	return JSON.parse_string(output)

# sets textures and sprites for loaded pal
func set_pal_parameters(pal: Node2D, color: Color, t_head: int, t_eyes: int, t_mouth: int, t_drip: int, t_tail: int):
	pal.get_node("Body").update_color(color)
	#pal.get_node("Head").put_texture(t_head)
	pal.get_node("Eyes").put_texture(t_eyes)
	pal.get_node("Mouth").put_texture(t_mouth)
	#pal.get_node("Drip").put_texture(t_drip)
	#pal.get_node("Tail").put_texture(t_tail)
	return

func extract_parameters_from_json():
	pass
