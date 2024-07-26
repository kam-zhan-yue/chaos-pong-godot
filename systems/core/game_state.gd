class_name GameState
extends Node

# Game Constants
const GAME_POINT = 11

# Systems
var tutorial_system: TutorialSystem

# Game Variables
var table: Table
var possession := Data.Team.NONE
var serving := Data.Team.NONE
var blue := 0
var red := 0
var state := PointState.WAITING

# Signals
signal blue_points(value: int)
signal red_points(value: int)
signal on_serve(team: Data.Team)
signal on_start(team: Data.Team)
signal on_restart
signal on_win(team: Data.Team)
signal on_new_game

const GAME_SETTINGS = preload("res://systems/resources/game_settings.tres")

enum PointState {
	WAITING,
	SCORED
}

func _init(table: Table = null) -> void:
	self.table = table
	self.tutorial_system = TutorialSystem.new()

func start() -> void:
	self.serving = GAME_SETTINGS.serving_team
	possession = Data.Team.NONE
	blue = 0
	red = 0
	state = PointState.WAITING
	on_start.emit(self.serving)

func get_round_type() -> Data.RoundType:
	var rounds = get_rounds()
	if tutorial_system:
		if not tutorial_system.over(rounds):
			return tutorial_system.get_round_type(rounds)
		else:
			return Data.get_round_type(rounds - tutorial_system.rounds()-1)
	else:
		return Data.get_round_type(rounds)
			

func get_rounds() -> int:
	return red + blue + 1

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
	if has_winner():
		on_win.emit(get_winner())
	else:
		red_points.emit(red)

func blue_point():
	blue += 1
	if has_winner():
		on_win.emit(get_winner())
	else:
		blue_points.emit(blue)
	
func get_serving_team() -> Data.Team:
	var swap := (blue + red) % 4 >= 2
	return Data.get_opposite(serving) if swap else serving

func game_point() -> bool:
	# Check if both teams have reached game point and has a lead of 1
	if blue >= GAME_POINT-1 and red >= GAME_POINT-1:
		return abs(blue-red) >= 1
	# Check if either team is approaching game point
	return blue >= GAME_POINT-1 or red >= GAME_POINT-1

func get_winner() -> Data.Team:
	# Check if either team has reached game point and has a lead of 2 or more
	if (blue >= GAME_POINT or red >= GAME_POINT) and abs(blue - red) >= 2:
		if blue > red:
			return Data.Team.BLUE
		else:
			return Data.Team.RED
	elif (blue>=GAME_POINT-1 and red >= GAME_POINT-1) and abs(blue-red) >= 2:
		if blue > red:
			return Data.Team.BLUE
		else:
			return Data.Team.RED
	return Data.Team.NONE

func restart_game() -> void:
	on_restart.emit()
	state = PointState.WAITING
		
func has_winner() -> bool:
	var winner = get_winner()
	if winner == Data.Team.NONE:
		return false
	else:
		return true
		
func new_game() -> void:
	on_new_game.emit()
