class_name PlayerAttackState
extends State
## The attack state for the player.

## The timer that is used for how long the player should attack.
@export var knockback_force: float = 180.0
@export var attack_timer: Timer
@export var hit_box_left: HitBox
@export var hit_box_right: HitBox
@export var animation_player: AnimationPlayer
@export var idle_state: PlayerIdleState
@export var velocity_component: VelocityComponent

func enter() -> void:
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	attack_timer.start()
	
	hit_box_left.hit_hurt_box.connect(_on_hit_hurt_box)
	hit_box_right.hit_hurt_box.connect(_on_hit_hurt_box)
	
	if parent.direction == Global.HorizontalDirection.LEFT:
		hit_box_left.enable()
	elif parent.direction == Global.HorizontalDirection.RIGHT:
		hit_box_right.enable()

func process(_delta: float) -> void:
	# Animation
	if parent.direction == Global.HorizontalDirection.LEFT:
		animation_player.play("attack_left")
	elif parent.direction == Global.HorizontalDirection.RIGHT:
		animation_player.play("attack_right")

func exit() -> void:
	attack_timer.timeout.disconnect(_on_attack_timer_timeout)
	attack_timer.stop()
	hit_box_left.hit_hurt_box.disconnect(_on_hit_hurt_box)
	hit_box_right.hit_hurt_box.disconnect(_on_hit_hurt_box)
	hit_box_left.disable()
	hit_box_right.disable()

func _on_hit_hurt_box(_hurt_box: HurtBox) -> void:
	velocity_component.add_force(knockback_force * parent.direction * -1)

func _on_attack_timer_timeout() -> void:
	parent.state_machine.change_state(idle_state)
