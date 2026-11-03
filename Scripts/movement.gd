extends CharacterBody2D

@export var MAX_SPEED = 150
@export var ACCELERATION = 150  # how fast you speed up
@export var DECELERATION = 150 # how fast you slow down when no key is held
@export var No_Hold_Deceleration = 1
@export var JUMP_VELOCITY = -400
@export var ROTATION_AT_100 = 100

@export var Slope_Gravity = 960
#var Slope_Gravity_Mod = 1
var  Time_On_Slope = 0
@export var Max_Slope_Speed = 1000
@export var Slope_Acceleration = 150
@export var Slope_Jump_mod = 1.4

#var Old_Floor_angle = Vector2(0,0)
var was_on_slope: bool = false
var last_slope_normal_x: float = 0.0

const RESTART_POSTITION = Vector2(0,0)


func _physics_process(delta: float) -> void:
	
	#var floor_normal = get_floor_normal()
	
	#print(str(floor_normal.x))
	
	#rotation = floor_normal.x
	
	if not is_on_floor():
		velocity += get_gravity() * delta



	var direction := Input.get_axis("Left", "Right")
	if direction and abs(velocity.x) > MAX_SPEED and (direction*velocity.x)>0:
		velocity.x = move_toward(velocity.x,direction*MAX_SPEED, No_Hold_Deceleration * delta)
	elif direction and is_on_floor():
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	elif is_on_floor() and not direction:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	$AnimatedSprite2D.speed_scale = velocity.x / ROTATION_AT_100

	var floor_angle = get_floor_normal()
	var on_floor = is_on_floor()
	var is_flat = abs(floor_angle.x) <= .05
	
	
	if is_on_floor():
		#print(str(velocity.x))
		if is_flat:
			Time_On_Slope = 1
		else:
			Time_On_Slope += (delta/2)
			
		if not is_flat:
			velocity.x = move_toward(velocity.x, floor_angle.x * Slope_Gravity, Slope_Acceleration * delta * (Time_On_Slope))
			velocity.x = clamp(velocity.x, -Max_Slope_Speed, Max_Slope_Speed)
			
	if was_on_slope and (is_flat or not on_floor):
		velocity.y = velocity.x * last_slope_normal_x * Slope_Jump_mod
		was_on_slope = false
	if on_floor and not is_flat:
		was_on_slope = true
		last_slope_normal_x = floor_angle.x
	else:
		was_on_slope = false
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()
	if Input.is_action_just_pressed("Reset"):
		global_position = RESTART_POSTITION
		velocity = Vector2.ZERO
		reset_physics_interpolation()
		
	
