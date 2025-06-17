extends CharacterBody2D

const speed = 20

@onready var nav_agent: NavigationAgent2D = $NavigationAgent

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = Vector2(1000,100)

func _on_timer_timeout():
	make_path()
