class_name Part_Selector_Component
extends Control

@onready var label: RichTextLabel = $tBody

@export var reference : Node2D

var folder_index := 0
var files : Array
var FOLDER

func _ready() -> void:
	FOLDER = reference.FOLDER
	label.text = reference.name
	$tBody.text = name # Sets UI label to parent name in editor
	files = get_folder_contents()
	if not files: return
	filter_files()
	set_pal_texture(folder_index) # Initialize sprite with first texture if available
	queue_redraw()

func _on_click_previous() -> void:
	print_debug(files)
	previous()

func _on_click_next() -> void:
	print_debug(files)
	next()

func previous() -> void: # on left button click
	if files.size() == 0:
		return
	folder_index -= 1
	if folder_index < 0:
		folder_index = files.size() - 1
	reference.texture = files[folder_index]

func next() -> void: # on right button click
	if files.size() == 0: return
	folder_index += 1
	if folder_index >= files.size():
		folder_index = 0
	print_debug(files[folder_index])
	#reference.texture = files[folder_index]
	reference.set_pal_texture(folder_index)

func get_folder_contents():
	var dir = DirAccess.open(FOLDER)
	if dir == null:
		print_debug("Could not open ", FOLDER)
		return
	return dir.get_files()

# Filter items ending on .png
func filter_files():
	files = files.filter(func(f):
		return f.ends_with(".png"))

func set_pal_texture(index: int) -> void:
	# Error Handling
	return
	if not files: print("ERROR: No assets in ",FOLDER); return
	print_debug(files)
	if index < 0 or index >= files.size(): 
		push_error("CRASH - Index out of bounds: ", index); return
	
	# Set texture
	var file_path = FOLDER + "/" + files[index]
	var char_tex = load(file_path)
	
	reference.texture = char_tex
	queue_redraw()
	#if not char_tex: print_debug("CRASH - Texture didn't load: ", file_path) # null error handlibn
	
