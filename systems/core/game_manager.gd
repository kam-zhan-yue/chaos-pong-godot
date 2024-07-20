extends Node2D

@onready var game_map: GameMap = $"../GameMap"
@onready var game := $".." as Node2D
@onready var game_events := %GameEvents as GameEvents
@onready var game_container := $"../CanvasLayer/GameContainer" as GameContainer
const WIZARD = preload("res://actors/wizard.tscn")
const BALL = preload("res://systems/ping_pong/ball.tscn")

var red_wizard: Wizard
var blue_wizard: Wizard
var ball: Ball
var state := State.IDLE
var game_state: GameState

signal red_points(value: int)
signal blue_points(value: int)

enum State {
	IDLE,
	SERVING,
	RETURNING,
	BREAK,
}

func _ready() -> void:
	setup_game()
	start_game(Data.Team.RED)
	
func setup_game() -> void:
	red_wizard = WIZARD.instantiate() as Wizard
	blue_wizard = WIZARD.instantiate() as Wizard
	red_wizard.init(Data.Team.RED)
	blue_wizard.init(Data.Team.BLUE)
	game_map.red_spawn.add_child(red_wizard)
	game_map.blue_spawn.add_child(blue_wizard)
	

func start_game(serving_team: Data.Team) -> void:
	game_state = GameState.new(serving_team, game_map.table)
	game_events.setup(game_state)
	game_container.setup(game_events)
	set_serve(serving_team)


func set_serve(serving_team: Data.Team) -> void:
	print('set serve')
	ball = BALL.instantiate() as Ball
	ball.init(game_state)
	self.add_child(ball)

	if serving_team == Data.Team.BLUE:
		blue_wizard.set_serving(ball)
		red_wizard.set_returning()
	elif serving_team == Data.Team.RED:
		red_wizard.set_serving(ball)
		blue_wizard.set_returning()

	state = State.SERVING


func _on_game_events_restart_game() -> void:
	set_serve(game_state.get_serving_team())
