class_name HitBox
extends Area2D
## Deals damage.

signal hit_hurt_box(hurt_box: HurtBox)

@export var parent: Node
## How much damage is dealt.
@export var power: int = 0 

func _init() -> void:
	collision_layer = 5
	collision_mask = 6

func _ready() -> void:
	area_entered.connect(_on_area_entered)

## Disabled the child CollisionShape2D.
func disable() -> void:
	get_collision_shape().disabled = true

## Disabled the child CollisionShape2D.
func enable() -> void:
	get_collision_shape().disabled = false

## Gets the child CollisionShape2D
func get_collision_shape() -> CollisionShape2D:
	return get_child(0) as CollisionShape2D

func _on_area_entered(area: Area2D) -> void:
	var hurt_box: HurtBox = area as HurtBox
	if hurt_box == null:
		return
	if hurt_box.owner == owner:
		return
	hit_hurt_box.emit(hurt_box)
