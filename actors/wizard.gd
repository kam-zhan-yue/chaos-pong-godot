class_name Wizard
extends CharacterBody2D

enum WizardState {
	IDLE,
	SERVING,
	RETURNING
}

# Player Variables
var id := 0
var team := Data.Team.NONE
var controls := Data.ControlScheme.KEYBOARD

# Nodes
@onready var paddle := $Paddle as Paddle
@onready var ball_spawn := $BallSpawn as Marker2D
@onready var health := %Health as Health

var round_type := Data.RoundType.PONG
var state := WizardState.IDLE
var ball: Ball

signal on_dead(team: Data.Team)
signal on_serve(team: Data.Team)
const SPEED := 200.0

const FIREBALL = preload("res://systems/magic/fireball.tscn")

func _physics_process(delta: float) -> void:
	var direction := Data.get_movement_vector(controls)
	var isometric := Vector2(direction.x, direction.y * 0.5).normalized()
	self.velocity = isometric * SPEED
	if state == WizardState.SERVING and ball:
		ball.move(ball_spawn.global_position)
	move_and_slide()
	
func init(id: int, control_scheme: Data.ControlScheme, team_side: Data.Team) -> void:
	team = team_side
	controls = control_scheme
	health = %Health as Health
	health.setup(team)

func idle() -> void:
	state = WizardState.IDLE

func reinit() -> void:
	health.setup(team)

func set_idle() -> void:
	state = WizardState.IDLE

func set_serving(ball: Ball) -> void:
	state = WizardState.SERVING
	self.ball = ball

func set_returning() -> void:
	state = WizardState.RETURNING

func set_round_type(round_type: Data.RoundType) -> void:
	self.round_type = round_type

func _input(event: InputEvent) -> void:
	if round_type != Data.RoundType.MAGIC and Input.is_action_just_pressed(Data.get_input(controls, "hit")):
		hit()
	if round_type != Data.RoundType.PONG and Input.is_action_just_pressed(Data.get_input(controls, "shoot")):
		shoot()

func hit() -> void:
	match state:
		WizardState.SERVING:
			ball.serve(team)
			set_returning()
		WizardState.RETURNING:
			paddle.try_return(team)


func shoot() -> void:
	if state != WizardState.RETURNING:
		return
	var fireball := FIREBALL.instantiate() as Fireball
	fireball.setup(team)
	get_parent().add_child(fireball)
	fireball.global_position = ball_spawn.global_position


func _on_health_on_dead() -> void:
	on_dead.emit(team)
	
