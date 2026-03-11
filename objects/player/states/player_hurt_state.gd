class_name PlayerHurtState
extends State

@export var idle_state: PlayerIdleState
@export var velocity_component: VelocityComponent
@export var health_component: HealthComponent
@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D

var knock_back_force: float = 270.0

func enter() -> void:
	velocity_component.add_force(knock_back_force * parent.direction * -1)
	health_component.invulnerability_ended.connect(_on_invulnerability_ended)
	sprite_2d.modulate = Color(1,1,1,0.5)

func process(_delta: float) -> void:
	if parent.direction == Global.HorizontalDirection.LEFT:
		animation_player.play("hurt_left")
	elif parent.direction == Global.HorizontalDirection.RIGHT:
		animation_player.play("hurt_right")

func exit() -> void:
	health_component.invulnerability_ended.disconnect(_on_invulnerability_ended)
	sprite_2d.modulate = Color(1,1,1,1)

func _on_invulnerability_ended() -> void:
	parent_machine.change_state(idle_state)
