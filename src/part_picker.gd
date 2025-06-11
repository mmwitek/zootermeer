extends Node2D

@onready var b_previous: Button = $bPrevious
@onready var b_next: Button = $bNext
@onready var sprite: Sprite2D = $Sprite

@export_dir var FOLDER: String = "res://assets/"
@export var folder_index := 0

#@export_group("Anchor Points")
@export var anchor : Vector2 = Vector2(-100000,0)

@export_group("Debug")
@export var debug_color : Color
@export var reference : Sprite2D

var files : Array

func _ready() -> void:
	
	$tBody.text = name # Sets UI label to parent name in editor
	inherit_reference()
	get_folder_contents()
	filter_files()

	# Initialize sprite with first texture if available
	set_texture(folder_index)
		#print(files.size(), " assets loaded from: ",FOLDER,"\n",files, "\n")
	queue_redraw()
	
	$Sprite.global_position = anchor

func next() -> void:
	if files.size() == 0: return
	folder_index += 1
	if folder_index >= files.size():
		folder_index = 0
	set_texture(folder_index)

func previous() -> void:
	if files.size() == 0: return
	folder_index -= 1
	if folder_index < 0:
		folder_index = files.size() - 1
	set_texture(folder_index)

func set_texture(index: int) -> void:
	# Error Handling
	if not files: print("ERROR: No assets in ",FOLDER); return
	if index < 0 or index >= files.size(): 
		push_error("CRASH - Index out of bounds: ", index); return
	
	# Set texture
	var file_path = FOLDER + "/" + files[index]
	var char_tex = load(file_path)
	# print_debug(files[index], " loaded successfully")
	
	# errors!
	if char_tex: sprite.texture = char_tex
	else: print_debug("CRASH - Texture didn't load: ", file_path)
	queue_redraw()

func _draw() -> void:
	draw_circle(anchor, 16, debug_color, true)
	

# Receives information about body part placement from Godot for easier adjustments
func inherit_reference():
	if not reference: return # null error handling
	
	print_debug(reference.global_position, " / ", sprite.global_position)
	sprite.global_position = reference.global_position
	reference.queue_free()
	sprite.scale = reference.scale


func get_folder_contents():
	var dir = DirAccess.open(FOLDER)
	if dir == null:
		print_debug("Could not open ", FOLDER)
		return
	files = dir.get_files()

# Filter items ending on .png
func filter_files():
	files = files.filter(func(f):
		return f.ends_with(".png"))
