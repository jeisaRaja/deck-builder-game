extends Node2D

@export var char_stats: CharacterStats
@export var music: AudioStream

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player as Player
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler


func _ready():
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	player.stats = new_stats

	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	Events.player_died.connect(_on_player_died)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)

	start_battle(new_stats)


func start_battle(stats: CharacterStats):
	MusicPlayer.play(music, true)
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)


func _on_enemy_turn_ended():
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()


func _on_enemies_child_order_changed():
	if enemy_handler.get_child_count() == 0:
		print("Victory!")


func _on_player_died():
	print("Game Over")
