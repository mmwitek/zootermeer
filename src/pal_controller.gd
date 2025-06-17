extends CharacterBody2D

@onready var camera: Camera2D = $Camera
@onready var nav_agent: NavigationAgent2D = $NavigationAgent

const SPEED = 100
var target := Vector2i(100,100)

func _ready() -> void:
	new_destination()
	#scale.x = -1 # somehow bad code, figure out how to flip properly

func _physics_process(delta: float) -> void:
	var next_pos = nav_agent.get_next_path_position()
	var dir = next_pos - global_position
	if dir.length() > 0:
		dir = dir.normalized()
	else:
		dir = Vector2.ZERO
	velocity = dir * SPEED
	move_and_slide()

func _destination_reached():
	$Timers/Cooldown_Navigation.start()
	set_physics_process(false)
	print_debug("destination reached")

func _cooldown_navigation_over():
	new_destination()
	set_physics_process(true)

func new_destination():
	nav_agent.target_position = Vector2i(
		randi_range(200, 800),
		randi_range(200, 800))
	#print_debug(name + " set a new path. Now walking to: " + str(nav_agent.target_position))
