class_name PongMap
extends TileMap

@onready var table := $Table as Table

func _ready() -> void:
	print(table)
