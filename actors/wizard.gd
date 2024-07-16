class_name Wizard
extends CharacterBody2D

enum WizardState {
	IDLE,
	SERVING,
	RETURNING
}

@onready var ball_spawn := $BallSpawn as Marker2D
var team := Data.Team.NONE
var state := WizardState.IDLE

signal serve(team: Data.Team)
const SPEED := 200.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var isometric := Vector2(direction.x, direction.y * 0.5).normalized()
	self.velocity = isometric * SPEED
	move_and_slide()
	
func init(team_side: Data.Team) -> void:
	team = team_side

func set_serve(ball: Ball) -> void:
	state = WizardState.SERVING
	ball_spawn.add_child(ball)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	match state:
		WizardState.SERVING:
			serve.emit(team)
