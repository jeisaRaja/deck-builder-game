class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

const BASE_STYLEBOX := preload("res://scenes/card_ui/icon/card_base_stylebox.tres")
const DRAG_STYLEBOX := preload("res://scenes/card_ui/icon/card_dragging_stylebox.tres")
const HOVER_STYLEBOX := preload("res://scenes/card_ui/icon/card_hover_stylebox.tres")

@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []
@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon

@export var card: Card:
	set = _set_card

@export var char_stats: CharacterStats:
	set = _set_char_stats

var original_index := 0
var parent: Control
var tween: Tween
var playable := true:
	set = _set_playable
var disabled := false


func _set_playable(value: bool):
	playable = value
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1, 1, 1, 0.5)
	else:
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1, 1, 1, 1)


func _ready() -> void:
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self)


func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)


func play() -> void:
	if not card:
		return
	card.play(targets, char_stats)
	queue_free()


func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	card = value
	cost.text = str(card.cost)
	icon.texture = card.icon


func _set_char_stats(value: CharacterStats):
	char_stats = value
	char_stats.stats_changed.connect(_on_char_stats_changed)


func _on_card_drag_or_aiming_started(used_card: CardUI) -> void:
	if used_card == self:
		return
	disabled = true


func _on_card_drag_or_aiming_ended(_card: CardUI) -> void:
	disabled = false
	self.playable = char_stats.can_play_card(card)


func _on_char_stats_changed():
	self.playable = char_stats.can_play_card(card)


func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)


func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)


func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()


func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_drop_point_detector_area_exited(area: Area2D):
	targets.erase(area)


func _on_drop_point_detector_area_entered(area: Area2D):
	if not targets.has(area):
		targets.append(area)
