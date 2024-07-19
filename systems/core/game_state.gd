class_name GameState
extends Node

var table: Table
var possession := Data.Team.NONE
var start := Data.Team.NONE
var round := 0
var blue := 0
var red := 0

signal on_point

func _init(start := Data.Team.NONE, table: Table = null):
	self.start = start
	self.table = table

func hit(side: Data.Team):
	possession = side
	print('Possession is now: ', Data.get_team(side))
	
func point(side: Data.Team):
	match side:
		Data.Team.RED:
			red_point()
		Data.Team.BLUE:
			blue_point()
		_:
			print('No point as possession is none')

func red_point():
	print('Point for Red')
	red += 1
	on_point.emit()

func blue_point():
	print('Point for Blue')
	blue += 1
	on_point.emit()
	
func get_serving_team() -> Data.Team:
	var swap := (blue + red) % 4 >= 2
	return Data.get_opposite(start) if swap else start
