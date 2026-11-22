extends Area2D
class_name Obstacle


@export var x_speed: float = 0.0
@export var y_offset: float = 0.0


var _game_time_ref: GameTimer


func _ready():
	body_entered.connect(_on_body_entered)


func add_gem_time_ref(game_time):
	_game_time_ref = game_time


func _process(delta: float) -> void:
	position.x -= (x_speed + _game_time_ref.get_time()) * delta
	if position.x < -1600:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is John:
		(body as John).hurt_player()
