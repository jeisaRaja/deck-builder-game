extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player as Player
@onready var enemy_hander: EnemyHandler = $EnemyHandler as EnemyHandler


func _ready():
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	player.stats = new_stats

	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_hander.start_turn)
	start_battle(new_stats)


func start_battle(stats: CharacterStats):
	enemy_hander.reset_enemy_actions()
	player_handler.start_battle(stats)


func _on_enemy_turn_ended():
	player_handler.start_turn()
	enemy_hander.reset_enemy_actions()
