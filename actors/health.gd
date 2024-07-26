class_name Health
extends Node2D

@export var max_health := 100.0
var health := 0.0
var team := Data.Team.NONE

signal on_dead

func setup(team: Data.Team) -> void:
	self.team = team
	health = max_health

func can_damage(other: Data.Team) -> bool:
	return other != team

func damage(amount: float) -> void:
	#print("%s damaged for %f" % [Data.get_team(team), amount])
	health -= amount
	if health <= 0:
		on_dead.emit()
