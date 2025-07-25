extends Button

var FOLDER := "res://pals"

@export var pal  : Node2D

@export_group("Pal Parts")
@export var body  : Sprite2D
@export var eyes  : Selector_Component
@export var mouth : Selector_Component
@export var head  : Selector_Component
@export var drip  : Selector_Component
@export var tail  : Selector_Component


func _pressed() -> void:
	save_pal_as_scene(pal)
	return
	
	var pal_json = create_json()
	save_pal(pal_json)
	print_debug("Pal saved successfully: " + pal_json)


func save_pal_as_scene(pal_node: Node2D):
	var scene = PackedScene.new()
	var result = scene.pack(pal_node)
	
	if result == OK:
		var error = ResourceSaver.save(scene, "res://pals/name.tscn")
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")











func create_json() -> String:
	var dict = {
		"param_body"  : body.color,
		"param_eyes"  : eyes.folder_index,
		"param_mouth" : mouth.folder_index,
		#"param_head"  : head.folder_index,
		#"param_drip"  : drip.folder_index,
		#"param_tail"  : tail.folder_index
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


func squish(): # flattens pal to be zapped up
	pass
