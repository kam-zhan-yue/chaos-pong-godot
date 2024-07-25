class_name GameContainer
extends Control

@onready var score_container := %ScoreContainer as ScoreContainer
@onready var start_container := %StartContainer as StartContainer
@onready var game_over_container := $GameOverContainer as GameOverContainer
var game_state: GameState

const GAME_SETTINGS = preload("res://systems/resources/game_settings.tres")

func _ready() -> void:
	Global.set_inactive(game_over_container)
	if GAME_SETTINGS.start_immediately:
		Global.set_inactive(start_container)

func setup(state: GameState) -> void:
	game_state = state
	game_state.on_win.connect(_on_win)
	score_container.setup(game_state)
	start_container.setup(game_state)
	game_over_container.on_restart.connect(_on_restart)

func _on_win(team: Data.Team) -> void:
	Global.set_inactive(score_container)
	Global.set_active(game_over_container)
	
func _on_restart() -> void:
	Global.set_active(score_container)
	Global.set_inactive(game_over_container)
	game_state.new_game()
