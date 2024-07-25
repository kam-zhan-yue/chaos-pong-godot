class_name GameOverContainer
extends Control
signal on_restart

func _on_restart_button_pressed() -> void:
	on_restart.emit()
