class_name Ball
extends Node2D

@onready var rigid_body_2d := $RigidBody2D as RigidBody2D

var current_side: Data.Team = Data.Team.NONE
var launch_timer := 0.0
var launch_time := 0.0
var launch_speed := 0.0
var launch_angle := 0.0
var start := Vector2.ZERO
var end := Vector2.ZERO
var table: Table
var bounces := 0

func init(table: Table) -> void:
	self.table = table

func _physics_process(delta: float) -> void:
	if launch_timer < launch_time:
		var next_position := Physics.simulate_position(start, launch_speed, launch_angle, Physics.GRAVITY, launch_timer)
		global_position = next_position
		launch_timer += delta
	elif launch_time > 0.0:
		bounce()

func bounce() -> void:
	bounces += 1
	if bounces > 2:
		queue_free() 
	# Calculate new end position and offset by height of block
	start = end
	end = Physics.simulate_position(start, launch_speed, launch_angle, Physics.GRAVITY, launch_time)
	end.y += Physics.BLOCK_HEIGHT
	launch(end)

func launch(target: Vector2) -> void:
	start = global_position
	end = target
	
	launch_speed = Physics.get_projectile_speed(start, end)
	launch_angle = Physics.get_projectile_angle(start, end)
	launch_time = Physics.get_projectile_time(start, end, launch_speed, launch_angle)
	launch_timer = 0
