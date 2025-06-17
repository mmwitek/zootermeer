extends Button

var FOLDER := "res://pals/"

@export_group("Pal Parts")
@export var body  : Node2D
@export var eyes  : Node2D
@export var mouth : Node2D
@export var head  : Node2D
@export var drip  : Node2D
@export var tail  : Node2D

func _pressed() -> void:
	var pal_json = create_json()
	save_pal(pal_json)
	print_debug("Pal saved successfully: " + pal_json)
	
func create_json() -> String:
	var dict = {
		"param_body"  : body.color,
		"param_eyes"  : eyes.folder_index,
		"param_mouth" : mouth.folder_index,
		"param_head"  : head.folder_index,
		"param_drip"  : drip.folder_index,
		"param_tail"  : tail.folder_index
	}
	return JSON.stringify(dict)

func save_pal(pal_string: String):
	var file_path = FOLDER + "pal-" + str(randi_range(1, 100000)) + ".json"
	var file_access := FileAccess.open(file_path, FileAccess.WRITE)
	if not file_access:
		print_debug("An error occured while saving: ", FileAccess.get_open_error())
		return
	file_access.store_line(pal_string)
	file_access.close()
