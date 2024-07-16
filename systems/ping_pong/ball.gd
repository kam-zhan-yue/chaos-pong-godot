class_name Ball
extends Node2D

@onready var rigid_body_2d := $RigidBody2D as RigidBody2D

var current_side: Data.Team = Data.Team.NONE

func launch(target: Vector2) -> void:
	print('Launching Ball to: ', target)
