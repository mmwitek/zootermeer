extends Node2D

var FOLDER := "res://pals/"

func _on_create_button_press() -> void:
	var pal_json = create_json()
	save_pal(pal_json)
	
func create_json() -> String:
	var dict = {
		"param_body"  : $Body.color,
		"param_eyes"  : $Eyes.folder_index,
		"param_mouth" : $Mouth.folder_index,
		"param_head"  : $Head.folder_index,
		"param_drip"  : $Drip.folder_index,
		"param_tail"  : $Tail.folder_index
	}
	return JSON.stringify(dict)

func save_pal(pal_string: String):
	var file_path = FOLDER + "pal-" + str(randi_range(1, 100000)) + ".json"
	var file_access := FileAccess.open(file_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(pal_string)
	file_access.close()
