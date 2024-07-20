class_name ScoreContainer
extends Control
@onready var blue_score := %BlueScore as Label
@onready var red_score := %RedScore as Label
@onready var score_top_container := %ScoreTopContainer as CenterContainer
@onready var score_popup := %ScorePopup as CenterContainer
@onready var blue_popup := %BluePopup as Label
@onready var red_popup := %RedPopup as Label

var game_state: GameState

func _ready() -> void:
	Global.set_inactive(score_popup)

func setup(state: GameState) -> void:
	game_state = state
	game_state.blue_points.connect(_on_blue_score)
	game_state.red_points.connect(_on_red_score)
	blue_score.set_text('0')
	red_score.set_text('0')

func _on_blue_score(value: int) -> void:
	await score_anim()
	blue_score.set_text(str(value))
	
func _on_red_score(value: int) -> void:
	await score_anim()
	red_score.set_text(str(value))

func score_anim() -> void:
	blue_popup.set_text(str(game_state.blue))
	red_popup.set_text(str(game_state.red))
	Global.set_inactive(score_top_container)
	Global.set_active(score_popup)
	await Global.seconds(1.0)
	Global.set_active(score_top_container)
	Global.set_inactive(score_popup)
	
	game_state.restart_game()
