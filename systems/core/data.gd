extends Node

enum Team {NONE, RED, BLUE}
enum ControlScheme {KEYBOARD, CONTROLLER}
enum RoundType {PONG, MAGIC, DUAL}

func get_opposite(team: Team) -> Team:
	if team == Team.RED:
		return Team.BLUE
	elif team == Team.BLUE:
		return Team.RED
	else:
		return Team.NONE

func get_team(team: Team) -> String:
	match team:
		Team.NONE:
			return 'None'
		Team.RED:
			return 'Red'
		Team.BLUE:
			return 'Blue'
		_:
			return 'None'
			
func round_type(round: RoundType) -> String:
	match round:
		RoundType.PONG:
			return 'Pong'
		RoundType.MAGIC:
			return 'Magic'
		RoundType.DUAL:
			return 'Dual'
		_:
			return 'None'

func get_input(scheme: ControlScheme, input: String) -> String:
	if scheme == ControlScheme.CONTROLLER:
		return "joy_"+input
	return input

func get_round_type(rounds: int) -> RoundType:
	var index := rounds % 6
	if index < 2:
		return RoundType.DUAL
	elif index < 4:
		return RoundType.PONG
	else:
		return RoundType.MAGIC
