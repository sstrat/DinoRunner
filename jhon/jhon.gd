extends CharacterBody2D

const JUMP_VELOCITY := -400.0
const FAST_FALL_SPEED := 900.0
const HITBOX_ROLL_Y := 20
const HITBOX_RUN_Y := -10

@export var lives := 3

var rolling := false
var hurting := false
var dying := false

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	animation.animation_finished.connect(_on_animation_finished)
	animation.play("run")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("roll") and not rolling:
		start_roll()
		if not is_on_floor():
			velocity.y = FAST_FALL_SPEED 

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		end_roll()

	move_and_slide()

	if rolling:
		pass 
	elif hurting:
		pass
	elif dying:
		pass
	elif not is_on_floor():
		play_anim("jump" if velocity.y < 0 else "fall")
	else:
		play_anim("run")

func play_anim(anim_name: String) -> void:
	if animation.animation != anim_name:
		animation.play(anim_name)

func start_roll() -> void:
	hitbox.position.y = HITBOX_ROLL_Y
	rolling = true
	animation.play("roll")

func end_roll() -> void:
	hitbox.position.y = HITBOX_RUN_Y
	rolling = false

func _on_animation_finished() -> void:
	if animation.animation == "roll":
		end_roll()
	if animation.animation == "hurt":
		hurting = false
		
func _on_hitbox_area_entered(area: Area2D):
	print("entered")
	#if area.is_in_group("obstacle")
	if lives > 0:
		hurting = true
		animation.play("hurt")
		lives = lives - 1;
	else:
		dying = true
		Global.speed = 0;
		animation.play("die")
	
