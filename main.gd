extends Node2D

@export var obstacle_scenes: Array[PackedScene] 
@export var spawn_x := 1000.0                   
@export var ground_top_y := 0.0                

var score := 0.0

func _ready() -> void:
	print("main ready")
	Global.speed = 400.0
	Global.playing = true
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	$SpawnTimer.one_shot = true
	$SpawnTimer.start(1.5)                     

func _process(delta: float) -> void:
	if not Global.playing:
		if Input.is_action_just_pressed("jump"):
			get_tree().reload_current_scene()
		return
	Global.speed += 5.0 * delta                  
	score += delta * 10.0

func _on_spawn_timer_timeout() -> void:
	print("spawn!")
	if not Global.playing:
		return
		
	var o = obstacle_scenes.pick_random().instantiate() as Area2D
	o.position = Vector2(spawn_x, ground_top_y + o.y_offset)
	add_child(o)
	
	$SpawnTimer.start(randf_range(1.0, 2.2))

func game_over() -> void:
	Global.playing = false
	print("game over")
