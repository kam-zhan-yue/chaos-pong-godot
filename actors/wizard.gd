extends CharacterBody2D

const SPEED := 200.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var isometric := Vector2(direction.x, direction.y * 0.5).normalized()
	self.velocity = isometric * SPEED
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		print('space pressed')
