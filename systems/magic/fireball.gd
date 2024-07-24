class_name Fireball
extends Spell

@export var speed := 5.0
@export var damage := 100.0

func _physics_process(delta: float) -> void:
	var velocity := Vector2.ZERO
	if team == Data.Team.RED:
		velocity = speed * Global.to_blue()
	elif team == Data.Team.BLUE:
		velocity = speed * Global.to_red()
	position += velocity

func _on_collision_box_area_entered(area: Area2D) -> void:
	if not area.has_method('can_damage') or not area.has_method('damage'):
		return
	if area.can_damage(team):
		queue_free()
		area.damage(damage)
