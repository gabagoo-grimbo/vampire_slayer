class_name VelocityComponent
extends Node

@export var parent: CharacterBody2D
@export var acceleration: float
@export var deceleration: float
@export var jump_force: float
@export var max_move_speed: float

## Should the parent jump this frame?
var should_jump: bool = false
var delta_x_velocity: float = 0
## Is movement caused by self (true) or an outside force like knockback (false).
var self_infliceted: bool = false

func physics_process(_delta: float) -> void:
	# Horizontal Movement
	if abs(delta_x_velocity) > 0:
		parent.velocity.x += delta_x_velocity
		if self_infliceted:
			parent.velocity.x = clamp(parent.velocity.x, -max_move_speed, max_move_speed)
			self_infliceted = false
	elif parent.is_on_floor():
		parent.velocity.x = move_toward(parent.velocity.x, 0, deceleration)
	
	delta_x_velocity = 0
	# Vertical Movement
	parent.velocity.y += Global.GRAVITY
	
	if parent.is_on_floor():
		if should_jump:
			parent.velocity.y -= jump_force
			should_jump = false
	
	parent.move_and_slide()

## Adds velocity in the direction given.
func move_in_direction(direction: Global.HorizontalDirection) -> void:
	delta_x_velocity += acceleration * direction
	self_infliceted = true

func add_force(force: float) -> void:
	delta_x_velocity += force

func jump() -> void:
	parent.velocity.y -= jump_force
