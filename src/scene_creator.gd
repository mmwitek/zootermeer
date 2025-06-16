extends Node2D # script to instance pngs into scenes

const SELECTOR = preload("res://src/selector.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instanced_scene = SELECTOR.instantiate()
	add_child(instanced_scene)
	instanced_scene.global_position = Vector2(200,200)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
