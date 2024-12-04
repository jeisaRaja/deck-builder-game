extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer


func _ready():
	Events.player_hit.connect(_on_player_hit)
	timer.timeout.connect(_on_timer_timeout)


func _on_player_hit():
	timer.start()
	color_rect.color.a = 0.2


func _on_timer_timeout():
	color_rect.color.a = 0.0
