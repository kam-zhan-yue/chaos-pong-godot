extends Node2D

@onready var pong_map := $"../PongMap" as PongMap
@onready var wizard: Wizard = $"../PongMap/Wizard" as Wizard

const BALL = preload("res://systems/ping_pong/ball.tscn")
var ball: Ball
var state := GameState.IDLE

enum GameState {
	IDLE,
	SERVING,
	RETURNING,
	BREAK,
}

func _ready() -> void:
	wizard.init(Data.Team.BLUE)
	ball = BALL.instantiate() as Ball
	wizard.set_serve(ball)
	state = GameState.SERVING

func _on_wizard_serve(team: int) -> void:
	var opposite: Data.Team = Data.get_opposite(team)
	var table_position := pong_map.table.get_table_position(opposite)
	ball.launch(table_position)
