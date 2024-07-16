extends Node

enum Team {NONE, RED, BLUE}

func get_opposite(team: Team) -> Team:
	if team == Team.RED:
		return Team.BLUE
	elif team == Team.BLUE:
		return Team.RED
	else:
		return Team.NONE
