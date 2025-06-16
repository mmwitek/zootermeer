extends Node2D

var PAL = "res://pals/pal-44558.json"
var FOLDER: String = "res://assets/"
var scene = preload("res://src/pal_template.tscn")
var pal_scene

func _ready() -> void:
	var pal = load_pal(PAL)
	print_debug("Pal loaded: " + pal)
	pal_scene = scene.instantiate()
	add_child(pal_scene)
	set_pal_parameters(
		pal_scene,
		Color.BLUE_VIOLET,
		0, # head
		1, # eyes
		2, # mouth
		0, # drip
		0  # tail
		)

func load_pal(load_path: String):
	var file_access := FileAccess.open(load_path, FileAccess.READ)
	if not file_access:
		print_debug("An error occured while saving: ", FileAccess.get_open_error())
		return null
	var output = file_access.get_line()
	file_access.close()
	return output

# sets textures and sprites for loaded pal
func set_pal_parameters(pal: Node2D, color: Color, t_head: int, t_eyes: int, t_mouth: int, t_drip: int, t_tail: int):
	pal.get_node("Body").update_color(color)
	#pal.get_node("Head").put_texture(t_head)
	pal_scene.get_node("Eyes").put_texture(t_eyes)
	pal_scene.get_node("Mouth").put_texture(t_mouth) # TODO: Figure out why its overlapping here
	#pal.get_node("Drip").put_texture(t_drip)
	#pal.get_node("Tail").put_texture(t_tail)
	return

func load_all_pals():
	return
