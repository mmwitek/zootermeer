extends Node2D

@onready var nav_region: NavigationRegion2D = $NavigationRegion2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var nav_polygon = nav_region.navigation_polygon
	if nav_polygon:
		var bounds = nav_polygon
		print("NavigationRegion bounds: ", bounds)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
