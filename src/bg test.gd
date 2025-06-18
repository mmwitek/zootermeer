extends Control

const CIRCLE_COUNT_X = 10
const CIRCLE_COUNT_Y = 6

const SPEED = Vector2(-25, -25)  # pixels per second
const SPEED_MULT = .2
const SIZE = 72
const PIXEL_CUTOFF = 40  # pixels outside the screen before wrapping

var screen_size = Vector2.ZERO
var circles = []

func _ready():
	screen_size = get_viewport_rect().size
	draw_circles()

func draw_circles():
	var spacing_x = screen_size.x / CIRCLE_COUNT_X * 1.1
	var spacing_y = screen_size.y / CIRCLE_COUNT_Y * 1.1
	for y in range(CIRCLE_COUNT_Y):
		for x in range(CIRCLE_COUNT_X):
			var circle_position = Vector2(
				(x + SPEED_MULT) * spacing_x,
				(y + SPEED_MULT) * spacing_y
			)
			circles.append(circle_position)
	queue_redraw()

func _draw():
	for pos in circles:
		draw_circle(pos, SIZE, Color.hex(00000020))

func _process(delta):
	for i in range(circles.size()):
		circles[i] += SPEED * delta
		# Wrap horizontally with PIXEL_CUTOFF margin
		if circles[i].x < -PIXEL_CUTOFF:
			circles[i].x += screen_size.x + 2 * PIXEL_CUTOFF
		elif circles[i].x > screen_size.x + PIXEL_CUTOFF:
			circles[i].x -= screen_size.x + 2 * PIXEL_CUTOFF
		# Wrap vertically with PIXEL_CUTOFF margin
		if circles[i].y < -PIXEL_CUTOFF:
			circles[i].y += screen_size.y + 2 * PIXEL_CUTOFF
		elif circles[i].y > screen_size.y + PIXEL_CUTOFF:
			circles[i].y -= screen_size.y + 2 * PIXEL_CUTOFF
	
	queue_redraw()
