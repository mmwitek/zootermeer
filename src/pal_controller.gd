extends CharacterBody2D

const speed = 100

@onready var camera: Camera2D = $Camera
@onready var nav_agent: NavigationAgent2D = $NavigationAgent
var target := Vector2i(100,100)

func _ready() -> void:
	#scale.x = -1 # somehow bad code, figure out how to flip properly
	make_path()

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	#if velocity.x < 0:
		#scale.x = -1
	#else:
		#scale.x = 1
	move_and_slide()
	#print_debug(velocity)

func make_path() -> void:
	nav_agent.target_position = target

func _on_timer_timeout():
	make_path()

func _destination_reached():
	new_destination()

func new_destination():
	target = Vector2i(
		randi_range(0, 100),
		randi_range(0, 100))
	print_debug("FINISHED")
	make_path()
