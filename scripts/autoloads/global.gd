extends Node

enum HorizontalDirection {
	LEFT = -1,
	NONE = 0,
	RIGHT = 1
}

const GRAVITY = 12.5

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
