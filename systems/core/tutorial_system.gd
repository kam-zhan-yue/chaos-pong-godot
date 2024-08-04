class_name TutorialSystem
extends Node

enum TutorialType {NONE, PONG, MAGIC, DUAL}

var tutorial := TutorialType.NONE

# Pong Tutorial Signals
signal on_pong_tutorial
signal on_move
signal on_serve
signal on_return

# Magic Tutorial Signals
signal on_wizard_tutorial
signal on_spell

# Dual Tutorial Signals
signal on_dual_tutorial

# Tutorial Over Signals
signal on_tutorial_over

var pong_games := 1
var magic_games := 1

func _input(event: InputEvent) -> void:
	if tutorial == TutorialType.PONG or tutorial == TutorialType.DUAL:
		var keyboard := Data.get_movement_vector(0, Data.ControlScheme.KEYBOARD)
		var controller := Data.get_movement_vector(0, Data.ControlScheme.CONTROLLER)
		if keyboard != Vector2.ZERO or controller != Vector2.ZERO:
			on_move.emit()
	elif tutorial == TutorialType.MAGIC or tutorial == TutorialType.DUAL:
		var keyboard_shoot := Data.get_input(0, Data.ControlScheme.KEYBOARD, "shoot")
		var controller_shoot := Data.get_input(0, Data.ControlScheme.CONTROLLER, "shoot")
		if Input.is_action_just_pressed(keyboard_shoot) or Input.is_action_just_pressed(controller_shoot):
			on_spell.emit()

func set_tutorial_type(current_round: int) -> void:
	if current_round > rounds() + 1:
		set_tutorial(TutorialType.NONE)
		return
	if current_round <= pong_games:
		set_tutorial(TutorialType.PONG)
	elif current_round <= rounds():
		set_tutorial(TutorialType.MAGIC)
	else:
		set_tutorial(TutorialType.DUAL)

func set_tutorial(type: TutorialType) -> void:
	if tutorial == type:
		return
	tutorial = type
	if tutorial == TutorialType.PONG:
		on_pong_tutorial.emit()
	elif tutorial == TutorialType.MAGIC:
		on_wizard_tutorial.emit()
	elif tutorial == TutorialType.DUAL:
		on_dual_tutorial.emit()

func emit_serve() -> void:
	if tutorial == TutorialType.PONG:
		on_serve.emit()

func emit_return() -> void:
	if tutorial == TutorialType.PONG:
		on_return.emit()

func get_round_type(round: int) -> Data.RoundType:
	if round <= pong_games:
		return Data.RoundType.PONG
	elif round <= (pong_games + magic_games):
		return Data.RoundType.MAGIC
	else:
		return Data.RoundType.DUAL

func over(round: int) -> bool:
	return round > rounds()

func rounds() -> int:
	return pong_games + magic_games
