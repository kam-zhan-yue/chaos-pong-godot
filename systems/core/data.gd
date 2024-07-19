extends Node

enum Team {NONE, RED, BLUE}

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
