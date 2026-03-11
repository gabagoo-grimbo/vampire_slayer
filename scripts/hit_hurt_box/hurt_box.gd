class_name HurtBox
extends Area2D
## Takes damage.

signal damage_taken(power: int)

@export var health_component: HealthComponent

func _init() -> void:
	collision_layer = 6
	collision_mask = 5

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hit_box: HitBox = area as HitBox
	if hit_box == null:
		return
	if hit_box.owner == owner:
		return
	print("butt")
	health_component.take_damage(hit_box.power)
	
	damage_taken.emit(hit_box.power)
