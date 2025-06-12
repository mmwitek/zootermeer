extends Node

signal DOOM # on big red button press

var color
signal color_change

func change_color(p_color: Color):
	emit_signal("color_change")
