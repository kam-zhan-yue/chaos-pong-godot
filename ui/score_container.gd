class_name ScoreContainer
extends HBoxContainer
@onready var blue_score := %BlueScore as Label
@onready var red_score := %RedScore as Label

func _on_blue_score(value: int) -> void:
	blue_score.set_text(str(value))
	
func _on_red_score(value: int) -> void:
	red_score.set_text(str(value))
