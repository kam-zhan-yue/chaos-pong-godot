extends Node2D

@onready var pong_map := $"../PongMap" as PongMap
@onready var blue_wizard: Wizard = $"../PongMap/BlueWizard" as Wizard
@onready var red_wizard: Wizard = $"../PongMap/RedWizard" as Wizard
@onready var game: Node2D = $".."

const BALL = preload("res://systems/ping_pong/ball.tscn")
var ball: Ball
var state := State.IDLE
@onready var game_state: GameState

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
	game_state.on_point.connect(_on_game_state_on_point)
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

func _on_game_state_on_point() -> void:
	set_serve(game_state.get_serving_team())
