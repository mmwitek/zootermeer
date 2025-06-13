extends Node2D

@export_dir var PAL_FOLDER := "res://pals/pal.tscn"

func _ready() -> void:
	pass

func _on_create_button_press() -> void: 
	var pal_color = $Body.color
	var pal_eyes = $Eyes.folder_index
	
	print(pal_eyes)
	return
	var new_scene = PackedScene.new()
	new_scene.pack(self)
	ResourceSaver.save(new_scene, PAL_FOLDER)
	
	$Button_Create.queue_free()
