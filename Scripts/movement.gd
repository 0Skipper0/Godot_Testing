extends CharacterBody2D

@export var MAX_SPEED = 150.0
@export var ACCELERATION = 75.0   # how fast you speed up
@export var DECELERATION = 200.0  # how fast you slow down when no key is held
@export var JUMP_VELOCITY = -400.0
@export var ROTATION_AT_100 = 100

const RESTART_POSTITION = Vector2(0,0)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and is_on_floor():
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	$AnimatedSprite2D.speed_scale = velocity.x / ROTATION_AT_100

	move_and_slide()
	
	if Input.is_physical_key_pressed(KEY_R):
		global_position = RESTART_POSTITION
		velocity = Vector2.ZERO
