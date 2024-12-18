extends Node

signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: Card)
signal card_drag_started(card: CardUI)
signal card_drag_ended(card: CardUI)
signal card_tooltip_requested(icon: Texture, text: String)
signal tooltip_hide_requested

signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
signal player_died
signal player_hit

signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended
