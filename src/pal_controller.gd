extends CharacterBody2D

@onready var camera: Camera2D = $Camera
@onready var nav_agent: NavigationAgent2D = $NavigationAgent

const SPEED = 100
var target : Vector2

var min_bound = Vector2(-117, 607)
var max_bound = Vector2(1344, 691)

func _ready() -> void:
	#global_position.x = 1000
	#print(global_position)
	#Vector2i(
		#randi_range(min_bound.x,max_bound.x),
		#randi_range(min_bound.y,max_bound.y)
	#)
	new_destination()

func _physics_process(delta: float) -> void:
	var next_pos = nav_agent.get_next_path_position()
	var dir = (next_pos - global_position).normalized()
	velocity = dir * SPEED
	move_and_slide()

func _destination_reached():
	$Timers/Cooldown_Navigation.start()
	set_physics_process(false)
	#print_debug(name + " reached its destination. Recalculating.")

func _cooldown_navigation_over():
	new_destination()
	set_physics_process(true)

func new_destination():
	target = Vector2(
		randi_range(min_bound.x, max_bound.x),
		randi_range(min_bound.y, max_bound.y)
	)
	nav_agent.target_position = target
	#print_debug(name + " set a new path. Now walking to: " + str(nav_agent.target_position))


func _on_area_entered(area: Area2D) -> void:
	print_debug("entered")
	pass # Replace with function body.
