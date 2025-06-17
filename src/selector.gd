class_name Selector_Component
extends Control

@onready var label: RichTextLabel = $tBody

@export var reference : Node2D

var folder_index := 0
var files : Array
var FOLDER

func _ready() -> void:
	if not reference: print_debug("No reference found for: " + name + ". Skipping assignment of textures."); return
	FOLDER = reference.FOLDER
	$tBody.text = reference.name # Sets UI label to parent name in editor
	files = get_folder_contents()
	if not files: return
	filter_files()
	queue_redraw()

func _on_click_previous() -> void:
	if files.size() == 0: return
	folder_index -= 1
	if folder_index < 0:
		folder_index = files.size() - 1
	set_pal_texture(folder_index)

func _on_click_next() -> void:
	if files.size() == 0: return
	folder_index += 1
	if folder_index >= files.size():
		folder_index = 0
	set_pal_texture(folder_index)

func set_pal_texture(index: int):
	reference.texture = load(str(
		FOLDER + "/" + files[index]
	))

func get_folder_contents():
	var dir = DirAccess.open(FOLDER)
	if dir == null:
		print_debug("Could not open ", FOLDER); return
	return dir.get_files()

# Filter items ending on .png
func filter_files():
	files = files.filter(func(f):
		return f.ends_with(".png"))
