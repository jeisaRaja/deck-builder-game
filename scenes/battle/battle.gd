extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI


func _ready():
	if battle_ui != null:
		print("ready battle.gd")
		var new_stats: CharacterStats = char_stats.create_instance()
		# battle_ui.char_stats = new_stats

		# Start the battle only after everything is ready
		start_battle(new_stats)
	else:
		print("Error: BattleUI is not ready")


func start_battle(_stats: CharacterStats):
	print("battle has started")
