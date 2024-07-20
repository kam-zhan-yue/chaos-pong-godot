class_name GameEvents
extends Node2D

signal red_points(value: int)
signal blue_points(value: int)
signal restart_game

var game_state: GameState

func setup(game_state: GameState) -> void:
	self.game_state = game_state
	self.game_state.on_red_point.connect(_on_red_point)
	self.game_state.on_blue_point.connect(_on_blue_point)


func _on_red_point(value: int) -> void:
	red_points.emit(value)
	restart_game.emit()


func _on_blue_point(value: int) -> void:
	blue_points.emit(value)
	restart_game.emit()
