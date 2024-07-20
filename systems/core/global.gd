extends Node

func seconds(time: float) -> void:
	await get_tree().create_timer(time).timeout
	
func frame() -> void:
	var delta := get_process_delta_time()
	await get_tree().create_timer(delta).timeout

func set_active(node: Node) -> void:
	active(node, true)
	
func set_inactive(node: Node) -> void:
	active(node, false)

func active(node: Node, active: bool) -> void:
	# Set visibility
	node.visible = active
	
	# Set general processing
	node.set_process(active)
	
	# Set physics processing
	node.set_physics_process(active)
	
	# Optionally, set input processing if needed
	if node.has_method("set_process_input"):
		node.set_process_input(active)
	
	# Optionally, set unhandled input processing if needed
	if node.has_method("set_process_unhandled_input"):
		node.set_process_unhandled_input(active)
