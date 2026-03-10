class_name HurtBox
extends Area2D
## Takes damage.

signal damage_taken(power: int)

@export var health_component: HealthComponent

func _init() -> void:
	collision_layer = 0
	collision_layer = 5

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null:
		return
	
	damage_taken.emit(hit_box.power)
