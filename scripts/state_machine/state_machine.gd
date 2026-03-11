class_name StateMachine
extends Node
## A simple finite state machine.

## The starting state of the machine.
@export var starting_state: State

## The current state of the machine.
var current_state: State

func _ready() -> void:
	for state in get_states():
		state.parent_machine = self
	
	assert(starting_state != null, "starting_state was null.")
	change_state(starting_state)

func process(delta: float) -> void:
	current_state.process(delta)

func physics_process(delta: float) -> void:
	current_state.physics_process(delta)

## Changes current_state to new_state.
func change_state(new_state: State) -> void:
	assert(new_state != null, "Could not find state to change to.")
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()

## Gets all children of type State in an array.
func get_states() -> Array[State]:
	var states: Array[State]
	for child in get_children():
		if child is State:
			states.append(child)
	return states
