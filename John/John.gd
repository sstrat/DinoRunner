extends CharacterBody2D
class_name John


signal dead


const JUMP_VELOCITY := -400.0
const FAST_FALL_SPEED := 900.0


@export var lives: int = 3
@export var max_jumps: int = 2
@export var animation: AnimatedSprite2D
@export var default_collision: CollisionShape2D
@export var roll_collision: CollisionShape2D


var jumps_used: int = 0
var rolling := false
var hurting := false
var dying := false
var is_dead := false


func _ready() -> void:
	assert(animation != null, "No AnimatedSprite2D connected!")
	assert(default_collision != null, "No default collision connected!")
	assert(roll_collision != null, "No roll collision connected!")
	
	animation.animation_finished.connect(_on_animation_finished)
	
	end_roll()
	animation.play("run")


func _physics_process(delta: float) -> void:
	if is_on_floor():
		jumps_used = 0
		if is_dead:
			dead.emit()
	else:
		velocity += get_gravity() * delta
	
	if not hurting and not dying:
		if Input.is_action_just_pressed("jump") and jumps_used < max_jumps:
			end_roll()
			velocity.y = JUMP_VELOCITY
			jumps_used += 1
		
		elif Input.is_action_just_pressed("roll") and not rolling:
			start_roll()
			
			if not is_on_floor():
				velocity.y = FAST_FALL_SPEED
	
	move_and_slide()
	update_animation()


func update_animation() -> void:
	if dying or hurting or rolling:
		return
	
	if is_on_floor():
		animation.play("run")
	elif velocity.y < 0:
		animation.play("jump")
	else:
		animation.play("fall")


func start_roll() -> void:
	if rolling or hurting or dying:
		return
	
	default_collision.set_deferred("disabled", true)
	roll_collision.set_deferred("disabled", false)
	rolling = true
	animation.play("roll")


func end_roll() -> void:
	default_collision.set_deferred("disabled", false)
	roll_collision.set_deferred("disabled", true)
	rolling = false


func hurt_player() -> void:
	if hurting or dying:
		return
	
	end_roll()
	lives -= 1
	
	if lives <= 0:
		dying = true
		animation.play("die")
	else:
		hurting = true
		animation.play("hurt")


func _on_animation_finished() -> void:
	match animation.animation:
		"roll":
			end_roll()
		"hurt":
			hurting = false
		"die":
			is_dead = true
