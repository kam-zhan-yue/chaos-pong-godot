class_name Spell
extends Node2D

var team := Data.Team.NONE

func setup(team: Data.Team) -> void:
	self.team = team
