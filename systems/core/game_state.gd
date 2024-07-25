class_name GameState
extends Node

var table: Table
var possession := Data.Team.NONE
var serving := Data.Team.NONE
var round := 0
var blue := 0
var red := 0
var state := PointState.WAITING

signal blue_points(value: int)
signal red_points(value: int)
signal on_serve(team: Data.Team)
signal on_start(team: Data.Team)
signal on_restart

const GAME_SETTINGS = preload("res://systems/resources/game_settings.tres")

enum PointState {
	WAITING,
	SCORED
}

func _init(table: Table = null):
	self.table = table

func start():
	self.serving = GAME_SETTINGS.serving_team
	on_start.emit(self.serving)

func serve(side: Data.Team):
	on_serve.emit(side)
	possession = side

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
	return Data.get_opposite(serving) if swap else serving

func restart_game() -> void:
	on_restart.emit()
	state = PointState.WAITING
