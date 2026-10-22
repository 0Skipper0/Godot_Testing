extends Camera2D

@export var NORMAL_ZOOM: float = 4.0
@export var TARGET_ZOOM: float = 1.0
@export var ZOOM_SPEED: float = 5.0

func _process(delta: float) -> void:
	var target: Vector2
	
	if Input.is_physical_key_pressed(KEY_E):
		target = Vector2(TARGET_ZOOM, TARGET_ZOOM)
	else:
		target = Vector2(NORMAL_ZOOM, NORMAL_ZOOM)
		
	zoom = zoom.lerp(target, ZOOM_SPEED * delta)
