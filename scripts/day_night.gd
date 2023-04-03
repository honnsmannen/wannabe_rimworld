class_name DayNightCycle
extends CanvasModulate

signal day_tick(day)
signal night_tick(night)

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
const EVENING_COLOR = Color("#ff3300")
const TIME_SCALE = 0.0



var night := false
var day := true
var time = 0
var last_day = 6

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	var value = (sin(time) + 1) / 2
	self.color = get_source_colour(value).linear_interpolate(get_target_colour(value), value)
	var new_day = _get_day()
	var new_night = _get_night()
	if new_day != last_day:
		last_day = new_day
		time = 2
		emit_signal("day_tick", new_day)
	if time > 3:
		night = true
		day = false
		emit_signal("night_tick", new_night)

		
func get_source_colour(value):
	return NIGHT_COLOR.linear_interpolate(EVENING_COLOR, value)

func get_target_colour(value):
	return EVENING_COLOR.linear_interpolate(DAY_COLOR, value)

func _get_night() -> int:
	var offset = 0
	return 1 + int(offset + (0.5 * time) / PI)

func _get_day() -> int:
	var offset = 0
	return 1 + int(offset + (0.5 * time) / PI)

