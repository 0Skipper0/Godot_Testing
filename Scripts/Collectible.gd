#extends AnimatedSprite2D
extends Node2D

@export var BOB_SPEED: float = .4
@export var BOB_HEIGHT: float = .2
@export var BOB_ENABLED: bool = true

var ORGINAL_Y: float
var TIME_PASSED: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ORGINAL_Y = position.y # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if BOB_ENABLED:
		TIME_PASSED += delta
		position.y = ORGINAL_Y + sin(TIME_PASSED*BOB_SPEED) * BOB_HEIGHT
