extends Node2D

@onready var pong_map := $"../PongMap" as PongMap
@onready var blue_wizard: Wizard = $"../PongMap/BlueWizard" as Wizard
@onready var red_wizard: Wizard = $"../PongMap/RedWizard" as Wizard
@onready var game: Node2D = $".."

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
	blue_wizard.init(Data.Team.BLUE)
	red_wizard.init(Data.Team.RED)
	set_serve(Data.Team.RED)


func set_serve(serving_team: Data.Team) -> void:
	ball = BALL.instantiate() as Ball
	ball.init(pong_map.table)
	self.add_child(ball)

	if serving_team == Data.Team.BLUE:
		blue_wizard.set_serving(ball)
		red_wizard.set_returning()
	elif serving_team == Data.Team.RED:
		red_wizard.set_serving(ball)
		blue_wizard.set_returning()

	state = GameState.SERVING
		

#func _on_wizard_serve(team: int) -> void:
	#ball.serve(team)
