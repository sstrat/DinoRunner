extends Area2D


@export var x_speed := 0.0
@export var y_offset := 0.0


func _ready():
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position.x -= x_speed * delta
	if position.x < -1600:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is John:
		(body as John).hurt_player()
