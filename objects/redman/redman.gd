extends CharacterBody2D

@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var direction: Global.HorizontalDirection = Global.HorizontalDirection.RIGHT

func _ready() -> void:
	health_component.died.connect(_on_died)

func _process(_delta: float) -> void:
	if direction == Global.HorizontalDirection.LEFT:
		animation_player.play("move_left")
	elif direction == Global.HorizontalDirection.RIGHT:
		animation_player.play("move_right")

func _physics_process(delta: float) -> void:
	if is_on_wall():
		if direction == Global.HorizontalDirection.LEFT:
			direction = Global.HorizontalDirection.RIGHT
		elif direction == Global.HorizontalDirection.RIGHT:
			direction = Global.HorizontalDirection.LEFT
	
	velocity_component.move_in_direction(direction)
	
	velocity_component.physics_process(delta)

func _on_died() -> void:
	queue_free()
