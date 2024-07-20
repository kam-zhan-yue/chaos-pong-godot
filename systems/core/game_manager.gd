extends Node2D

@onready var pong_map := $"../PongMap" as PongMap
@onready var blue_wizard: Wizard = $"../PongMap/BlueWizard" as Wizard
@onready var red_wizard: Wizard = $"../PongMap/RedWizard" as Wizard
@onready var game := $".." as Node2D
@onready var game_events := %GameEvents as GameEvents
@onready var game_container: GameContainer = $"../CanvasLayer/GameContainer"

const BALL = preload("res://systems/ping_pong/ball.tscn")
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
	blue_wizard.init(Data.Team.BLUE)
	red_wizard.init(Data.Team.RED)
	start_game(Data.Team.RED)

func start_game(serving_team: Data.Team) -> void:
	game_state = GameState.new(serving_team, pong_map.table)
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
