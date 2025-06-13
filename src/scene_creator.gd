extends Node2D # script to instance pngs into scenes

@export var Reference : Node2D

func _on_create_pressed():
	var packed_scene = PackedScene.new()
	var ID := randi_range(0, 10000)
	packed_scene.pack(Reference)
	print_debug(packed_scene)
