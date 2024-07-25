extends Node2D

@onready var game_map: GameMap = $"../GameMap"
@onready var game := $".." as Node2D
@onready var game_container := $"../CanvasLayer/GameContainer" as GameContainer

# Instantiation
const WIZARD = preload("res://actors/wizard.tscn")
const BALL = preload("res://systems/ping_pong/ball.tscn")
const GAME_SETTINGS = preload("res://systems/resources/game_settings.tres")

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
	init_players()
	setup_game()
	if GAME_SETTINGS.start_immediately:
		game_state.start()
	
func init_players() -> void:
	red_wizard = WIZARD.instantiate() as Wizard
	blue_wizard = WIZARD.instantiate() as Wizard
	
	red_wizard.init(0, Data.ControlScheme.KEYBOARD, Data.Team.RED)
	blue_wizard.init(1, Data.ControlScheme.CONTROLLER, Data.Team.BLUE)
	
	red_wizard.on_dead.connect(_on_wizard_dead)
	blue_wizard.on_dead.connect(_on_wizard_dead)
	
	game_map.red_spawn.add_child(red_wizard)
	game_map.blue_spawn.add_child(blue_wizard)

func setup_game() -> void:
	game_state = GameState.new(game_map.table)
	game_state.on_start.connect(_start_game)
	game_state.on_restart.connect(_restart_game)
	game_state.on_serve.connect(_on_serve)
	game_state.on_new_game.connect(_on_new_game)
	
	game_container.setup(game_state)


func set_serve(serving_team: Data.Team) -> void:
	ball = BALL.instantiate() as Ball
	ball.init(game_state)
	self.add_child(ball)
	
	red_wizard.reinit()
	blue_wizard.reinit()

	if serving_team == Data.Team.BLUE:
		blue_wizard.set_serving(ball)
		red_wizard.set_idle()
	elif serving_team == Data.Team.RED:
		red_wizard.set_serving(ball)
		blue_wizard.set_idle()
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
	
func _start_game(serving: Data.Team) -> void:
	set_serve(serving)

func _restart_game() -> void:
	await lerp_positions()
	set_serve(game_state.get_serving_team())

func _on_serve(team: Data.Team) -> void:
	var opposite := Data.get_opposite(team)
	get_wizard(opposite).set_returning()

func _on_wizard_dead(team: Data.Team) -> void:
	if game_state.can_score():
		red_wizard.idle()
		blue_wizard.idle()
		ball.queue_free()
		game_state.point(Data.get_opposite(team))
	
func get_wizard(team: Data.Team) -> Wizard:
	if team == Data.Team.BLUE:
		return blue_wizard
	elif team == Data.Team.RED:
		return red_wizard
	return null

func _on_new_game() -> void:
	setup_game()
	game_state.start()
