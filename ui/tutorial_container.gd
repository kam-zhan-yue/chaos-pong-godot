class_name TutorialContainer
extends Control

var tutorial_system: TutorialSystem
@onready var title := %Title as Label
@onready var instruction_container := %InstructionContainer as VBoxContainer
const INSTRUCTION_LABEL = preload("res://ui/instruction_label.tscn")

var instructions: Array[InstructionLabel] = []

func setup(system: TutorialSystem) -> void:
	tutorial_system = system
	tutorial_system.on_pong_tutorial.connect(_show_pong_tutorial)
	tutorial_system.on_wizard_tutorial.connect(_show_wizard_tutorial)
	tutorial_system.on_dual_tutorial.connect(_show_dual_tutorial)

func _show_pong_tutorial() -> void:
	clear_instructions()
	title.set_text("Ping Pong Instructions.")
	var move := instantiate_instruction("[WASD] / [Left Joystick] to move")
	var serve := instantiate_instruction("[Space] / [A] to serve")
	var return_ball := instantiate_instruction("[Space] / [A] to return")
	tutorial_system.on_move.connect(move._complete)
	tutorial_system.on_serve.connect(serve._complete)
	tutorial_system.on_return.connect(return_ball._complete)

func _show_wizard_tutorial() -> void:
	clear_instructions()
	title.set_text("Magic Instructions.")
	var spell := instantiate_instruction("[M] / [B] to cast a spell")
	tutorial_system.on_spell.connect(spell._complete)

func _show_dual_tutorial() -> void:
	clear_instructions()
	title.set_text("Now... Combine Everything.")
	var serve := instantiate_instruction("[Space] / [A] to serve")
	var return_ball := instantiate_instruction("[Space] / [A] to return")
	var spell := instantiate_instruction("[M] / [B] to cast a spell")
	tutorial_system.on_serve.connect(serve._complete)
	tutorial_system.on_return.connect(return_ball._complete)
	tutorial_system.on_spell.connect(spell._complete)

func clear_instructions() -> void:
	for label in instructions:
		label.queue_free()
	instructions = []

func instantiate_instruction(text: String) -> InstructionLabel:
	var instruction := INSTRUCTION_LABEL.instantiate() as InstructionLabel
	instruction.set_text(text)
	instruction_container.add_child(instruction)
	instructions.append(instruction)
	return instruction

