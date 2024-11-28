class_name CardState
extends Node

enum State { BASE, CLICKED, DRAGGING, AIMING, RELEASED }
signal transition_requested(from: CardState, to: State)

@export var state: State

var card_ui: CardUI

