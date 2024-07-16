class_name TableTop
extends Area2D

@onready var collision_polygon := $CollisionPolygon2D as CollisionPolygon2D

func _ready() -> void:
	print(get_random_point())

func get_random_point() -> Vector2:
	var polygon := collision_polygon.polygon
	var triangles := Geometry2D.triangulate_polygon(polygon)
	var triangle_index: int = randi() % (triangles.size() / 3);
	
	var a: Vector2 = polygon[triangles[3 * triangle_index + 0]]
	var b: Vector2 = polygon[triangles[3 * triangle_index + 1]]
	var c: Vector2 = polygon[triangles[3 * triangle_index + 2]]
	
	return random_triangle_point(a, b, c) + position

func random_triangle_point(a: Vector2, b: Vector2, c: Vector2) -> Vector2:
	return a + sqrt(randf()) * (-a + b + randf() * (c - b))
