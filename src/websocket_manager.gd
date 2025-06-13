extends Node

var socket = WebSocketPeer.new()
@export var is_enabled := true

func _ready():
	var IP_ADDRESS := "wss://zootermeer.netlify.app:8080"
	connect_to_server(IP_ADDRESS)
	var state = socket.get_ready_state()
	
	if state == WebSocketPeer.STATE_CONNECTING:
		print_debug("Connecting to ", IP_ADDRESS)
	set_process(is_enabled)

## Boilerplate WebSocket code from Godot docs
#  https://docs.godotengine.org/en/stable/classes/class_websocketpeer.html
func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	print("Current state: ", state)
	
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			print("Packet: ", socket.get_packet())
	
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code:")
		set_process(false)


func connect_to_server(ws_url: String):
	var err = socket.connect_to_url(ws_url)
	if err != OK:
		print("Failed to connect")
