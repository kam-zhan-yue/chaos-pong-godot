class_name Fireball
extends Spell

var speed := 5.0

func _physics_process(delta: float) -> void:
	var velocity := Vector2.ZERO
	if team == Data.Team.RED:
		velocity = speed * Global.to_blue()
	elif team == Data.Team.BLUE:
		velocity = speed * Global.to_red()
	position += velocity
