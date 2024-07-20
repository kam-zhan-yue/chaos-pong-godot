class_name GameContainer
extends Control

@onready var score_container: ScoreContainer = %ScoreContainer

func _ready() -> void:
	print('game container')

func setup(game_state: GameState) -> void:
	score_container.setup(game_state)
