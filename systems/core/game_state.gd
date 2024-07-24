class_name GameState
extends Node

var table: Table
var possession := Data.Team.NONE
var start := Data.Team.NONE
var round := 0
var blue := 0
var red := 0
var state := PointState.WAITING

signal blue_points(value: int)
signal red_points(value: int)
signal restart

enum PointState {
	WAITING,
	SCORED
}

func _init(start := Data.Team.NONE, table: Table = null):
	self.start = start
	self.table = table

func hit(side: Data.Team):
	possession = side
	
func can_score() -> bool:
	return state != PointState.SCORED
	
func point(side: Data.Team):
	if not can_score():
		return
	state = PointState.SCORED
	match side:
		Data.Team.RED:
			red_point()
		Data.Team.BLUE:
			blue_point()
		_:
			print('No point as possession is none')

func red_point():
	red += 1
	red_points.emit(red)

func blue_point():
	blue += 1
	blue_points.emit(blue)
	
func get_serving_team() -> Data.Team:
	var swap := (blue + red) % 4 >= 2
	return Data.get_opposite(start) if swap else start

func restart_game() -> void:
	restart.emit()
	state = PointState.WAITING
