extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler


func _ready():
	if battle_ui != null:
		var new_stats: CharacterStats = char_stats.create_instance()
		battle_ui.char_stats = new_stats

		start_battle(new_stats)
	else:
		print("Error: BattleUI is not ready")


func start_battle(stats: CharacterStats):
	player_handler.start_battle(stats)
