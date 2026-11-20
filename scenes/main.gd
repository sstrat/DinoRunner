extends Node2D


@export var player: John


var is_player_dead: bool = false


func _ready() -> void:
	assert(player != null, "No player connected!")
	
	player.dead.connect(_register_the_player_death)


func _register_the_player_death():
	is_player_dead = true
	get_tree().paused = true


func _unhandled_input(event: InputEvent) -> void:
	if not is_player_dead:
		return
	
	if event.is_action_pressed("jump"):
		get_tree().paused = false
		get_tree().reload_current_scene()
