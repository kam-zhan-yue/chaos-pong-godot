extends Node

const GRAVITY = Vector2(0, -100)

func get_projectile_speed(start: Vector2, end: Vector2) -> float:
	var g := GRAVITY.length()
	var x := end.x - start.x
	var y := end.y - start.y
	var sqrt1 := sqrt(y * y + x * x)
	var sqrt2 := sqrt(g * y + g * sqrt1)
	return sqrt2

func get_projectile_angle(start: Vector2, end: Vector2) -> float:
	var x := end.x - start.x
	var y := end.y - start.y
	if x >= 0:
		return rad_to_deg(atan2(y/x + sqrt((y*y)/(x*x)+1), 1.0))
	else:
		return rad_to_deg(atan2(1.0, -1.0 * y/x - sqrt((y*y)/(x*x)+1)))

func get_projectile_time(start: Vector2, end: Vector2, v: float, angle: float) -> float:
	var x := end.x - start.x
	var vX := v * cos(deg_to_rad(angle))
	var time := x / vX
	return time
	
func simulate_position(start: Vector2, speed: float, angle: float, a: Vector2, t: float) -> Vector2:
	var angle_rad := deg_to_rad(angle)
	var u := Vector2(speed * cos(angle_rad), speed * sin(angle_rad))
	var v := u + a * t
	return start + u * t + a * (0.5 * t * t)
