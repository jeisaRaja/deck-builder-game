extends EnemyAction

@export var mega_block := 15
@export var hp_threshold := 6

var already_used := false


func is_performable():
	if not enemy or already_used:
		return
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low

	return is_low


func perform_action():
	if not enemy:
		return
	var block_effect := BlockEffect.new()
	block_effect.amount = mega_block
	block_effect.sound = sound
	block_effect.execute([enemy])

	get_tree().create_timer(0.6).timeout.connect(func(): Events.enemy_action_completed.emit(enemy))
