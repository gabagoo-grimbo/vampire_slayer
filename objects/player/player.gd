class_name Player
extends CharacterBody2D
## The player class.

## The gravity that is applied to the player every frame.
const GRAVITY: float = 12.5
## How fast the player moves horizontally.
const MAX_MOVE_SPEED: float = 90.0
## The force applied to the player when they jump.
const JUMP_FORCE: float = 240.0
const DECELERATION: float = 6.0
const ACCELERATION: float = 10.0

var direction: Global.HorizontalDirection = Global.HorizontalDirection.RIGHT
var is_attacking: bool = false

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var state_machine: StateMachine = %StateMachine
@onready var health_component: HealthComponent = %HealthComponent
@onready var hit_box_left: HitBox = %HitBoxLeft
@onready var hit_box_right: HitBox = %HitBoxRight

func _ready() -> void:
	hit_box_left.disable()
	hit_box_right.disable()

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
