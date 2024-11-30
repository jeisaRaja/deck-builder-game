extends CardState

var played: bool


func enter() -> void:
	played = false

	if not card_ui.targets.is_empty():
		played = true
		card_ui.play()


func _process(_delta: float) -> void:
	if not played and card_ui.card_state_machine.current_state.state == CardState.State.RELEASED:
		print("Transitioning to BASE...", self)
		transition_requested.emit(self, CardState.State.BASE)


func on_input(_event: InputEvent) -> void:
	if played:
		return
	transition_requested.emit(self, CardState.State.BASE)


