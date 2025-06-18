extends CharacterBody2D

@onready var camera: Camera2D = $Camera
@onready var nav_agent: NavigationAgent2D = $NavigationAgent

@onready var dialogue: Node2D = $Dialogue
@onready var chat_message: RichTextLabel = $Dialogue/VBoxContainer/Chat_Message

const FORMATTING = "[p align=center][color=black]"
const SPEED = 100

var target : Vector2
var min_bound = Vector2(-117, 607)
var max_bound = Vector2(1344, 691)

var skip_initial_interaction = true
var is_chatting = false


func _ready() -> void:
	global_position = Vector2i(
		randi_range(min_bound.x,max_bound.x),
		randi_range(min_bound.y,max_bound.y)
	)
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
	if skip_initial_interaction:
		skip_initial_interaction = false
		return
	interact()


func interact():
	if is_chatting: return
	chat()


func chat():
	is_chatting = true
	var random_msg_id = randi_range(
		0, Messages.msg.size() - 1)
	var message = Messages.msg[random_msg_id]
	set_physics_process(false)
	$Timers/Duration_Interaction.start()
	dialogue.visible = true
	chat_message.text = FORMATTING + message


func stop_chatting():
	dialogue.visible = false
	set_physics_process(true)
	new_destination()
	is_chatting = false
