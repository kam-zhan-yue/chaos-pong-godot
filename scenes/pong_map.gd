class_name PongMap
extends TileMap

@onready var table: Table = $Table

func _ready() -> void:
	print(table)
