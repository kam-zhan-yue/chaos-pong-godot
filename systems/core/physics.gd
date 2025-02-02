extends Node

const GRAVITY = Vector2(0, 200)
const BLOCK_HEIGHT = 16.0
const BLOCK_WIDTH = 32.0

# Calculate y as start.y - end.y due to Godot's handling of coordinate system
func get_projectile_speed(start: Vector2, end: Vector2) -> float:
	var g := GRAVITY.length()
	var x := end.x - start.x
	var y := start.y - end.y
	var sqrt1 := sqrt(y * y + x * x)
	var sqrt2 := sqrt(g * y + g * sqrt1)
	return sqrt2

func get_projectile_angle(start: Vector2, end: Vector2) -> float:
	var x := end.x - start.x
	var y := start.y - end.y
	var a := y/x
	if x >= 0:
		return rad_to_deg(PI * 0.5 - 0.5 * (PI * 0.5 - atan(a)))
	else:
		return rad_to_deg(PI - 0.5 * (PI * 0.5 - atan(a)))

func get_projectile_time(start: Vector2, end: Vector2, v: float, angle: float) -> float:
	var x := end.x - start.x
	var vX := v * cos(deg_to_rad(angle))
	var time := x / vX
	return time

func get_velocity(speed: float, angle: float) -> Vector2:
	var angle_rad := deg_to_rad(angle)
	return Vector2(speed * cos(angle_rad), -speed * sin(angle_rad))
	
func simulate_position(start: Vector2, speed: float, angle: float, a: Vector2, t: float) -> Vector2:
	var u := get_velocity(speed, angle)
	return start + u * t + a * (0.5 * t * t)
