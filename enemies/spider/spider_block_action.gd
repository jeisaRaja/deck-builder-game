extends EnemyAction

@export var block := 6


func perform_action():
	if not enemy:
		return
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	block_effect.sound = sound

	get_tree().create_timer(0.6, false).timeout.connect(
		func(): Events.enemy_action_completed.emit(enemy)
	)
