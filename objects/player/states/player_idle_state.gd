class_name PlayerIdleState
extends State
## The idle, walk, and jump state for the player.

@export var velocity_component: VelocityComponent
@export var animation_player: AnimationPlayer
@export var attack_state: PlayerAttackState
@export var block_state: PlayerBlockState

func process(_delta: float) -> void:
	# Animation
	if parent.direction == Global.HorizontalDirection.LEFT:
		if not parent.is_on_floor():
			animation_player.play("jump_left")
		elif Input.is_action_pressed("move_left"):
			animation_player.play("move_left")
		else:
			animation_player.play("idle_left")
	elif parent.direction == Global.HorizontalDirection.RIGHT:
		if not parent.is_on_floor():
			animation_player.play("jump_right")
		elif Input.is_action_pressed("move_right"):
			animation_player.play("move_right")
		else:
			animation_player.play("idle_right")

func physics_process(_delta: float) -> void:
	# Horizontal Movement
	var input: float = Input.get_axis("move_left", "move_right")
	if input < 0:
		velocity_component.move_in_direction(Global.HorizontalDirection.LEFT)
		parent.direction = Global.HorizontalDirection.LEFT
	elif input > 0:
		velocity_component.move_in_direction(Global.HorizontalDirection.RIGHT)
		parent.direction = Global.HorizontalDirection.RIGHT
	
	# Vertical Movement
	if parent.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity_component.jump()
	
	# Attacking
	if Input.is_action_just_pressed("attack"):
		parent_machine.change_state(attack_state)
	elif Input.is_action_just_pressed("block"):
		parent_machine.change_state(block_state)
