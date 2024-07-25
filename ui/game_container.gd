class_name GameContainer
extends Control

@onready var score_container := %ScoreContainer as ScoreContainer
@onready var start_container := %StartContainer as StartContainer

const GAME_SETTINGS = preload("res://systems/resources/game_settings.tres")

func _ready() -> void:
	if GAME_SETTINGS.start_immediately:
		Global.set_inactive(start_container)
	
func setup(game_state: GameState) -> void:
	score_container.setup(game_state)
	start_container.setup(game_state)
