class_name PlayerBlockState
extends State
## The block state for the player.

@export var player: Player

func process(_delta: float) -> void:
	# Animation
	if player.direction == Global.Direction.LEFT:
		player.animation_player.play("block_left")
	elif player.direction == Global.Direction.RIGHT:
		player.animation_player.play("block_right")

func physics_process(_delta: float) -> void:
	# Horizontal Movement
	if player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.DECELERATION)
	player.velocity.x = clamp(player.velocity.x, -player.MAX_MOVE_SPEED, player.MAX_MOVE_SPEED)
	
	# Vertical Movement
	player.velocity.y += player.GRAVITY
	
	player.move_and_slide()
	
	if not Input.is_action_pressed("block"):
		player.state_machine.change_state("PlayerIdleState")

func _on_block_timer_timeout() -> void:
	player.state_machine.change_state("PlayerIdleState")
