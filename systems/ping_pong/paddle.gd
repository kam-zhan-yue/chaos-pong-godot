class_name Paddle
extends Area2D

func try_return(team: Data.Team) -> bool:
	var bodies := get_overlapping_bodies()
	print(get_parent().name, team)
	for body in bodies:
		var ball := body.get_parent() as Ball
		print(ball, team)
		if ball and ball.can_return(team):
			ball.hit()
			return true
	return false
