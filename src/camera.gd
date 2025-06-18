extends Camera2D

var initial_zoom
var camera_bounds : Array

func _ready() -> void:
	#print_debug(position.x)
	#print_debug(get_viewport().size.x)
	#scale = initial_zoom
	pass

func _process(delta: float) -> void:
	# implement dynamic zooming based on how many pals are on screen
	pass

func adjust():
	
	return
