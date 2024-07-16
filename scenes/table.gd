class_name Table
extends Node2D
@onready var red_area: TableTop = $"Red Area"
@onready var blue_area: TableTop = $"Blue Area"

func _physics_process(delta: float) -> void:
	for overlap in red_area.get_overlapping_bodies():
		print('overlap: ', overlap.get_parent().name)

func get_table_position(team: Data.Team) -> Vector2:
	if team == Data.Team.BLUE:
		return blue_area.get_random_point()
	else:
		return red_area.get_random_point()
