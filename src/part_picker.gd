extends Node2D

@onready var b_previous: Button = $bPrevious
@onready var b_next: Button = $bNext
@onready var sprite: Sprite2D = $Sprite

@export_dir var FOLDER: String = "res://assets/"
@export var debug_color : Color
@export var reference : Pal_Picker_Element

var folder_index := 0
var files : Array

func _ready() -> void:
	print_debug(name, " loaded")
	$tBody.text = name # Sets UI label to parent name in editor
	inherit_reference()
	files = get_folder_contents()
	if not files: return
	filter_files()
	set_texture(folder_index) # Initialize sprite with first texture if available
	queue_redraw()

func previous() -> void: # on left button click
	if files.size() == 0:
		return
	folder_index -= 1
	if folder_index < 0:
		folder_index = files.size() - 1
	set_texture(folder_index)

func next() -> void: # on right button click
	if files.size() == 0: return
	folder_index += 1
	if folder_index >= files.size():
		folder_index = 0
	set_texture(folder_index)

func set_texture(index: int) -> void:
	# Error Handling
	if not files: print("ERROR: No assets in ",FOLDER); return
	print_debug(files)
	if index < 0 or index >= files.size(): 
		push_error("CRASH - Index out of bounds: ", index); return
	
	# Set texture
	var file_path = FOLDER + "/" + files[index]
	var char_tex = load(file_path)
	
	sprite.texture = char_tex
	queue_redraw()
	if not char_tex: print_debug("CRASH - Texture didn't load: ", file_path) # null error handlibn
	

## Receives information about body part placement from Godot for easier adjustments
func inherit_reference():
	if not reference: return # null error handling
	#print_debug(reference.global_position, " / ", sprite.global_position)
	sprite.global_position = reference.global_position
	reference.queue_free()
	sprite.scale = reference.scale

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
