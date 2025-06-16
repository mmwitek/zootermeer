extends Node2D

var PAL = "res://pals/pal-44558.json"
var FOLDER: String = "res://assets/"
var pal_scene

func _ready() -> void:
	var pal = load_pal(PAL)
	print_debug("Pal loaded: " + pal)
	var scene = load("res://src/pal_creator.tscn")
	pal_scene = scene.instantiate()
	add_child(pal_scene)
	set_pal_parameters(
		pal_scene,
		Color.BLUE_VIOLET,
		0,
		1,
		0,
		0,
		0
		)

func load_pal(load_path: String) -> String:
	var file_access := FileAccess.open(load_path, FileAccess.READ)
	if not file_access:
		print_debug("An error occured while saving: ", FileAccess.get_open_error())
		return ""
	var output = file_access.get_line()
	file_access.close()
	return output

# sets textures and sprites for loaded pal
func set_pal_parameters(pal: Node2D, color: Color, texture_head: int, texture_eyes: int, texture_mouth: int, texture_drip: int, texture_tail: int):
	pal.get_node("Body").update_color(color)
	#pal.get_node("Head").set_texture(texture_head)
	pal.get_node("Eyes").set_texture(texture_eyes)
	#pal.get_node("Mouth").set_texture(texture_mouth)
	#pal.get_node("Drip").set_texture(texture_drip)
	#pal.get_node("Tail").set_texture(texture_tail)

func load_all_pals():
	return
