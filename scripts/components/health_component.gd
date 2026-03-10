class_name HealthComponent
extends Node

signal took_damage(power: int)
signal died

@export var max_health: int
## Its like iframes but in seconds
@export var iseconds: int = 0

var current_health: int
var is_invulnerable: bool = false

func _ready() -> void:
	current_health = max_health

func take_damage(power: int) -> void:
	if is_invulnerable:
		return
	current_health -= power
	took_damage.emit(power)
	if current_health < 0:
		current_health = 0
		died.emit()
		return
	if iseconds > 0:
		is_invulnerable = true
		get_tree().create_timer(iseconds).timeout.connect(_on_iseconds_finished)

func _on_iseconds_finished() -> void:
	is_invulnerable = false
