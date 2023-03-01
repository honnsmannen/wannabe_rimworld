class_name DayNightCycle
extends CanvasModulate

signal day_tick(day)

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
const EVENING_COLOR = Color("#ff3300")
const TIME_SCALE = 0.01

var night := false
var time = 0
var last_day = 6

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	var value = (sin(time) + 1) / 2
	self.color = get_source_colour(value).linear_interpolate(get_target_colour(value), value)
	print(time)
	var new_day = _get_day()
	if new_day != last_day:
		last_day = new_day
		time = 0
		emit_signal("day_tick", new_day)
		print("new day")
		print(time)
	if time > 3:
		night = true
		print("night")
	else:
		print("day")


		
func get_source_colour(value):
	return NIGHT_COLOR.linear_interpolate(EVENING_COLOR, value)

func get_target_colour(value):
	return EVENING_COLOR.linear_interpolate(DAY_COLOR, value)

func _get_day() -> int:
	# this is required as midnight is not perfectly dark
	var offset = 0
	return 1 + int(offset + (0.5 * time) / PI)

