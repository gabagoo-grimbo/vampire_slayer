class_name HitBox
extends Area2D
## Deals damage.

## How much damage is dealt.
@export var power: int = 0 

func _init() -> void:
	collision_layer = 5
	collision_mask = 0

## Disabled the child CollisionShape2D.
func disable() -> void:
	get_collision_shape().disabled = true

## Disabled the child CollisionShape2D.
func enable() -> void:
	get_collision_shape().disabled = false

## Gets the child CollisionShape2D
func get_collision_shape() -> CollisionShape2D:
	return get_child(0) as CollisionShape2D
