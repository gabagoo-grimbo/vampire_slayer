@abstract
class_name State
extends Node
## Class for states in StateMachine.

## The machine that the state belongs to.
var parent_machine: StateMachine
## The parent object the state belongs to.
var parent: Node

## Called when state is changed in to.
func enter() -> void: pass
## Called every frame
func process(_delta: float) -> void: pass
## Called every physics frame.
func physics_process(_delta: float) -> void: pass
## Called when state is changed out of.
func exit() -> void: pass
