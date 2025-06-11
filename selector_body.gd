extends Node2D
@onready var b_previous: Button = $bPrevious
@onready var b_next: Button = $bNext
@onready var sprite: Sprite2D = $Sprite

@export_dir var FOLDER: String = "res://assets/"
@export var array_index := 0

#@export_group("Anchor Points")
@export var anchor : Vector2 = Vector2(-100000,0)

@export_group("Debug")
@export var debug_color : Color

var files := []

func _ready() -> void:
	$tBody.text = name
	var dir = DirAccess.open(FOLDER)
	if dir == null:
		print_debug("Could not open ", FOLDER)
		return
	files = dir.get_files()

	# Filter items ending on .png
	files = files.filter(func(f):
		return f.ends_with(".png"))

	print(files.size(), " assets loaded from: ",FOLDER,"\n",files, "\n")
	# Initialize sprite with first texture if available
	if files.size() > 0:
		set_texture(array_index)
	queue_redraw()
	
	$Sprite.global_position = anchor

func next() -> void:
	if files.size() == 0: return
	array_index += 1
	if array_index >= files.size():
		array_index = 0
	set_texture(array_index)

func previous() -> void:
	if files.size() == 0: return
	array_index -= 1
	if array_index < 0:
		array_index = files.size() - 1
	set_texture(array_index)

func set_texture(index: int) -> void:
	# Error Handling
	if index < 0 or index >= files.size(): push_error("CRASH - Index out of bounds: ", index); return
	
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
