@abstract
class_name State
extends Node
## Class for states in StateMachine.

## Called when state is changed in to.
func enter() -> void: pass
## Called every frame
func process(_delta: float) -> void: pass
## Called every physics frame.
func physics_process(_delta: float) -> void: pass
## Called when state is changed out of.
func exit() -> void: pass
