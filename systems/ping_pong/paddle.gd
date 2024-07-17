class_name Paddle
extends Area2D

func _physics_process(delta: float) -> void:
	var bodies := get_overlapping_areas()
	for body in bodies:
		print(get_parent().name, body.get_parent().name)

func try_return(team: Data.Team) -> bool:
	var bodies := get_overlapping_areas()
	print(get_parent().name, team)
	for body in bodies:
		var ball := body.get_parent() as Ball
		print(ball, team)
		if ball and ball.can_return(team):
			ball.hit()
			return true
	return false
