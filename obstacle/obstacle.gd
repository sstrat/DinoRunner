extends Area2D

@export var own_speed := 0.0
@export var y_offset := 0.0

func _ready() -> void:
	add_to_group("obstacle")

func _process(delta: float) -> void:
	if not Global.playing:
		return
	position.x -= (Global.speed + own_speed) * delta
	if position.x < -1000:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().current_scene.game_over();
