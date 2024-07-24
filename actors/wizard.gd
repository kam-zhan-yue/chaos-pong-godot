class_name Wizard
extends CharacterBody2D

enum WizardState {
	IDLE,
	SERVING,
	RETURNING
}
@onready var paddle := $Paddle as Paddle
@onready var ball_spawn := $BallSpawn as Marker2D
var team := Data.Team.NONE
var state := WizardState.IDLE
var ball: Ball

signal serve(team: Data.Team)
const SPEED := 200.0

const FIREBALL = preload("res://systems/magic/fireball.tscn")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var isometric := Vector2(direction.x, direction.y * 0.5).normalized()
	self.velocity = isometric * SPEED
	if state == WizardState.SERVING and ball:
		ball.move(ball_spawn.global_position)
	move_and_slide()
	
func init(team_side: Data.Team) -> void:
	team = team_side

func set_serving(ball: Ball) -> void:
	state = WizardState.SERVING
	self.ball = ball

func set_returning() -> void:
	state = WizardState.RETURNING

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("hit"):
		hit()
	if Input.is_action_just_pressed("shoot"):
		shoot()

func hit() -> void:
	match state:
		WizardState.SERVING:
			ball.serve(team)
			set_returning()
		WizardState.RETURNING:
			paddle.try_return(team)

func shoot() -> void:
	var fireball := FIREBALL.instantiate() as Fireball
	fireball.setup(team)
	get_parent().add_child(fireball)
	fireball.global_position = ball_spawn.global_position
