extends Node2D

@onready var game_map: GameMap = $"../GameMap"
@onready var game := $".." as Node2D
@onready var game_container := $"../CanvasLayer/GameContainer" as GameContainer
const WIZARD = preload("res://actors/wizard.tscn")
const BALL = preload("res://systems/ping_pong/ball.tscn")

var red_wizard: Wizard
var blue_wizard: Wizard
var ball: Ball
var state := State.IDLE
var game_state: GameState

signal red_points(value: int)
signal blue_points(value: int)

enum State {
	IDLE,
	SERVING,
	RETURNING,
	BREAK,
}

func _ready() -> void:
	setup_game()
	start_game(Data.Team.RED)
	
func setup_game() -> void:
	red_wizard = WIZARD.instantiate() as Wizard
	blue_wizard = WIZARD.instantiate() as Wizard
	red_wizard.init(Data.Team.RED)
	blue_wizard.init(Data.Team.BLUE)
	game_map.red_spawn.add_child(red_wizard)
	game_map.blue_spawn.add_child(blue_wizard)
	

func start_game(serving_team: Data.Team) -> void:
	game_state = GameState.new(serving_team, game_map.table)
	game_state.restart.connect(_restart_game)
	game_container.setup(game_state)
	set_serve(serving_team)


func set_serve(serving_team: Data.Team) -> void:
	print('set serve')
	ball = BALL.instantiate() as Ball
	ball.init(game_state)
	self.add_child(ball)

	if serving_team == Data.Team.BLUE:
		blue_wizard.set_serving(ball)
		red_wizard.set_returning()
	elif serving_team == Data.Team.RED:
		red_wizard.set_serving(ball)
		blue_wizard.set_returning()

	state = State.SERVING

func lerp_positions() -> void:
	lerp_transform(blue_wizard, game_map.blue_spawn, 0.5)
	await lerp_transform(red_wizard, game_map.red_spawn, 0.5)
	
func lerp_transform(wizard: Wizard, spawn: Marker2D, duration: float):
	var time := 0.0
	var start_position := wizard.global_position
	while time < duration:
		var delta := get_process_delta_time()
		time += delta
		var t := Ease.in_out(time / duration)
		wizard.global_position = start_position.lerp(spawn.global_position, t)
		await Global.frame()
	wizard.global_position = spawn.global_position
	
func _restart_game() -> void:
	await lerp_positions()
	set_serve(game_state.get_serving_team())
