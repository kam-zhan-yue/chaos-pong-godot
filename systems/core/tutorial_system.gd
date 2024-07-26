class_name TutorialSystem
extends Node

signal on_pong_tutorial
signal on_wizard_tutorial
signal on_dual_tutorial
signal on_tutorial_over

var pong_games := 1
var magic_games := 1

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
