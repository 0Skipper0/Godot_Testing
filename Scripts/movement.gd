extends CharacterBody2D

@export var MAX_SPEED = 150
@export var ACCELERATION = 75  # how fast you speed up
@export var DECELERATION = 200 # how fast you slow down when no key is held
@export var JUMP_VELOCITY = -400
@export var ROTATION_AT_100 = 100

@export var Slope_Gravity = 600
@export var Max_Slope_Speed = 1000


const RESTART_POSTITION = Vector2(0,0)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Left", "Right")
	if direction and is_on_floor() and velocity.x<=MAX_SPEED:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	elif is_on_floor() and not direction:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	$AnimatedSprite2D.speed_scale = velocity.x / ROTATION_AT_100

	move_and_slide()
	
	
	if is_on_floor():
		var floor_normal = get_floor_normal()
		# floor_normal.x is positive when sliding down-right, negative when down-left
		if floor_normal.x != 0:
			
			
			velocity.x += floor_normal.x * Slope_Gravity * delta
			velocity.x = clamp(velocity.x, -Max_Slope_Speed, Max_Slope_Speed)
	
	if Input.is_action_just_pressed("Reset"):
		global_position = RESTART_POSTITION
		velocity = Vector2.ZERO
		reset_physics_interpolation()
		
	
