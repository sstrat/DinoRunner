extends Node2D


const STARTING_SPEED: float = -300.0

const SKY_SCROLL_RATE: float = 0.15
const SEA_SCROLL_RATE: float = 0.25
const ISLANDS_SCROLL_RATE: float = 0.35
const MOUNTAINS_SCROLL_RATE: float = 0.5
const FOREST_SCROLL_RATE: float = 0.65
const GRASS_SCROLL_RATE: float = 1.15


@export var game_time: GameTimer
@export var sky_layer: Parallax2D
@export var sea_layer: Parallax2D
@export var island_layer: Parallax2D
@export var mountains_layer: Parallax2D
@export var forest_layer: Parallax2D
@export var ground_layer: Parallax2D
@export var gras_layer: Parallax2D


func _ready():
	assert(game_time != null, "No game time connected!")
	assert(sky_layer != null, "No parallax layer missing!")
	assert(sea_layer != null, "No parallax layer missing!")
	assert(island_layer != null, "No parallax layer missing!")
	assert(mountains_layer != null, "No parallax layer missing!")
	assert(forest_layer != null, "No parallax layer missing!")
	assert(ground_layer != null, "No parallax layer missing!")
	assert(gras_layer != null, "No parallax layer missing!")


func _process(_delta):
	ground_layer.autoscroll.x = STARTING_SPEED - game_time.get_time()
	
	sky_layer.autoscroll.x = ground_layer.autoscroll.x * SKY_SCROLL_RATE
	sea_layer.autoscroll.x = ground_layer.autoscroll.x * SEA_SCROLL_RATE
	island_layer.autoscroll.x = ground_layer.autoscroll.x * ISLANDS_SCROLL_RATE
	mountains_layer.autoscroll.x = ground_layer.autoscroll.x * MOUNTAINS_SCROLL_RATE
	forest_layer.autoscroll.x = ground_layer.autoscroll.x * FOREST_SCROLL_RATE
	gras_layer.autoscroll.x = ground_layer.autoscroll.x * GRASS_SCROLL_RATE
