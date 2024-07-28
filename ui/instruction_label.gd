class_name InstructionLabel
extends RichTextLabel

var completed := false

func _complete() -> void:
	if completed:
		return
	completed = true
	set_text("[s]" + text + "[/s]")
	print('completed', text)
