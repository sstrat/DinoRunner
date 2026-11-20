extends Marker2D


@export var spawn_timer: Timer
@export var obstacle_scenes: Array[PackedScene]
@export var obstacle_container: Node2D
@export var spawn_x := 700.0
@export var ground_top_y := 0.0


func _ready() -> void:
	assert(spawn_timer != null, "No timmer connected!")
	assert(obstacle_container != null, "No container connected!")
	
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start(1.5)                     


func _on_spawn_timer_timeout() -> void:
	var obstacle = obstacle_scenes.pick_random().instantiate() as Area2D
	obstacle.position = Vector2(spawn_x, ground_top_y + obstacle.y_offset)
	obstacle_container.add_child(obstacle)
	
	spawn_timer.start(randf_range(1.0, 2.2))
