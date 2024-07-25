extends Node

enum Team {NONE, RED, BLUE}
enum ControlScheme {KEYBOARD, CONTROLLER}

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

func get_input(scheme: ControlScheme, input: String) -> String:
	if scheme == ControlScheme.CONTROLLER:
		return "joy_"+input
	return input
