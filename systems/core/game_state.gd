class_name GameState
extends Node

var table: Table
var possession := Data.Team.NONE
var start := Data.Team.NONE
var round := 0
var blue := 0
var red := 0

signal on_blue_point(value: int)
signal on_red_point(value: int)


func _init(start := Data.Team.NONE, table: Table = null):
	self.start = start
	self.table = table

func hit(side: Data.Team):
	possession = side
	
func point(side: Data.Team):
	match side:
		Data.Team.RED:
			red_point()
		Data.Team.BLUE:
			blue_point()
		_:
			print('No point as possession is none')

func red_point():
	red += 1
	on_red_point.emit(red)

func blue_point():
	blue += 1
	on_blue_point.emit(blue)
	
func get_serving_team() -> Data.Team:
	var swap := (blue + red) % 4 >= 2
	return Data.get_opposite(start) if swap else start
