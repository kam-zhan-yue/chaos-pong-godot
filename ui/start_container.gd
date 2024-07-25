class_name StartContainer
extends Control

var game_state: GameState

func setup(game_state: GameState) -> void:
	self.game_state = game_state

func _on_button_pressed() -> void:
	game_state.start()
	Global.set_inactive(self)
