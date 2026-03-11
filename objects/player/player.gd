class_name Player
extends CharacterBody2D
## The player class.

var direction: Global.HorizontalDirection = Global.HorizontalDirection.RIGHT
var attack_power: int = 1

@onready var state_machine: StateMachine = %StateMachine
@onready var hurt_state: PlayerHurtState = %PlayerHurtState
@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var hit_box_left: HitBox = %HitBoxLeft
@onready var hit_box_right: HitBox = %HitBoxRight

func _ready() -> void:
	hit_box_left.disable()
	hit_box_right.disable()
	
	hit_box_left.power = attack_power
	hit_box_right.power = attack_power
	
	health_component.took_damage.connect(_on_took_damage)

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
	velocity_component.physics_process(delta)

func _on_took_damage(_power: int) -> void:
	state_machine.change_state(hurt_state)
