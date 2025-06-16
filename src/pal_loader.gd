extends Node

var FOLDER := "res://pals/"
var PAL = "res://pals/pal-52596.json"

func _ready() -> void:
	var pal = load_pal(PAL)
	print_debug(pal)

func _process(delta: float) -> void:
	pass

func load_pal(load_path: String) -> String:
	var file_access := FileAccess.open(load_path, FileAccess.READ)
	if not file_access:
		print_debug("An error occured while saving: ", FileAccess.get_open_error())
		return ""
	var output = file_access.get_line()
	file_access.close()
	return output

# sets textures and sprites for loaded pal
func set_pal_parameters():
	
	pass
