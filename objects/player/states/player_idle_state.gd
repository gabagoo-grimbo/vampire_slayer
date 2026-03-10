class_name PlayerIdleState
extends State
## The idle, walk, and jump state for the player.

@export var player: Player

func process(_delta: float) -> void:
	# Animation
	if player.direction == Global.Direction.LEFT:
		if not player.is_on_floor():
			player.animation_player.play("jump_left")
		elif abs(player.velocity.x) > 0:
			player.animation_player.play("move_left")
		else:
			player.animation_player.play("idle_left")
	elif player.direction == Global.Direction.RIGHT:
		if not player.is_on_floor():
			player.animation_player.play("jump_right")
		elif abs(player.velocity.x) > 0:
			player.animation_player.play("move_right")
		else:
			player.animation_player.play("idle_right")

func physics_process(_delta: float) -> void:
	# Horizontal Movement
	var input: float = Input.get_axis("move_left", "move_right")
	if input:
		player.velocity.x += player.ACCELERATION * input
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DECELERATION)
	
	player.velocity.x = clamp(player.velocity.x, -player.MAX_MOVE_SPEED, player.MAX_MOVE_SPEED)
	
	if input > 0:
		player.direction = Global.HorizontalDirection.RIGHT
	elif input < 0:
		player.direction = Global.HorizontalDirection.LEFT
	
	# Vertical Movement
	player.velocity.y += player.GRAVITY
	
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			player.velocity.y -= player.JUMP_FORCE
	
	player.move_and_slide()
	
	# Attacking
	if Input.is_action_just_pressed("attack"):
		player.state_machine.change_state("PlayerAttackState")
	elif Input.is_action_just_pressed("block"):
		player.state_machine.change_state("PlayerBlockState")
