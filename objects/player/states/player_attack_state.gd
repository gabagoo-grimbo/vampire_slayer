class_name PlayerAttackState
extends State
## The attack state for the player.

@export var player: Player
## The timer that is used for how long the player should attack.
@export var attack_timer: Timer

func enter() -> void:
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	attack_timer.start()
	
	if player.direction == Global.Direction.LEFT:
		player.hit_box_left.enable()
	elif player.direction == Global.Direction.RIGHT:
		player.hit_box_right.enable()

func process(_delta: float) -> void:
	# Animation
	if player.direction == Global.Direction.LEFT:
		player.animation_player.play("attack_left")
	elif player.direction == Global.Direction.RIGHT:
		player.animation_player.play("attack_right")

func physics_process(_delta: float) -> void:
	# Horizontal Movement
	if player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.DECELERATION)
	player.velocity.x = clamp(player.velocity.x, -player.MAX_MOVE_SPEED, player.MAX_MOVE_SPEED)
	
	# Vertical Movement
	player.velocity.y += player.GRAVITY
	
	player.move_and_slide()

func exit() -> void:
	attack_timer.timeout.disconnect(_on_attack_timer_timeout)
	attack_timer.stop()

func _on_attack_timer_timeout() -> void:
	player.state_machine.change_state("PlayerIdleState")
	player.hit_box_left.disable()
	player.hit_box_right.disable()
