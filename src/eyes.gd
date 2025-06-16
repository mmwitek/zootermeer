extends Sprite2D

@export_dir var FOLDER := "res://assets/"
var textures := []  # Array to hold loaded textures
var dir

func _ready() -> void:
	dir = DirAccess.open(FOLDER)
	textures = dir.get_files()
	filter_files()
	put_texture(0)

func put_texture(texture_ID: int) -> void:
	var texture_full_path = str(
		FOLDER, "/", textures[texture_ID]
	)
	
	var loaded_texture = load(texture_full_path)
	texture = loaded_texture
	pass

# Filter items ending on .png
func filter_files():
	textures = textures.filter(func(f):
		return f.ends_with(".png"))
