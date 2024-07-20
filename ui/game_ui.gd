class_name GameContainer
extends Control
@onready var score_container := $PanelContainer/CenterContainer/HBoxContainer as ScoreContainer

func _ready() -> void:
	print('game container')

func setup(game_events: GameEvents) -> void:
	game_events.blue_points.connect(score_container._on_blue_score)
	game_events.red_points.connect(score_container._on_red_score)
