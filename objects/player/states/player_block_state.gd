class_name PlayerBlockState
extends State
## The block state for the player.

@export var animation_player: AnimationPlayer
@export var idle_state: PlayerIdleState

func process(_delta: float) -> void:
	# Animation
	if parent.direction == Global.HorizontalDirection.LEFT:
		animation_player.play("block_left")
	elif parent.direction == Global.HorizontalDirection.RIGHT:
		animation_player.play("block_right")

func physics_process(_delta: float) -> void:
	if not Input.is_action_pressed("block"):
		parent_machine.change_state(idle_state)

func _on_block_timer_timeout() -> void:
	parent_machine.change_state(idle_state)
