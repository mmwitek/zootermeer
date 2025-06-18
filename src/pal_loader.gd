extends Node2D

var PAL = "res://pals/pal-41536.json"
var FOLDER: String = "res://assets/"
var PAL_FOLDER: String = "res://pals/"
var scene = preload("res://src/pal_template.tscn")

func _ready() -> void:
	var dir = DirAccess.open(PAL_FOLDER)
	var textures = dir.get_files()
	
	for i in textures.size(): # load all pals in folder
		add_pal_from_json(PAL_FOLDER + textures[i])


func add_pal_from_json(json_string: String):
	var pal_values = load_json_file(json_string)
	var pal_node : Node2D = scene.instantiate()
	add_child(pal_node)
	#pal_node.global_position = Vector2(500,500)
	print_debug(pal_values["param_body"])
	#return
	set_pal_parameters(
		pal_node, # referenced scene
		Color.ORANGE_RED, #pal_values["param_body"], # body color # TODO: Figure out why the color isn't saved, exporting to col gives a black value in RGB
		0, # head
		pal_values["param_eyes"], # eyes
		pal_values["param_mouth"], # mouth
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

func extract_parameters_from_json():
	pass
