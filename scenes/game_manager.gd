extends Node2D

@onready var wizard: CharacterBody2D = $"../Map/Wizard"
@onready var pong_map: PongMap = $"../PongMap"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		serve_ball()

func serve_ball() -> void:
	print('serve')
	print(pong_map)
	print(pong_map.table)
	
	#print(map.table.get_table_position(Data.Team.BLUE))
