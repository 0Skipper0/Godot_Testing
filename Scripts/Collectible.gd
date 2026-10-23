#extends AnimatedSprite2D
extends Node2D

@export var BOB_SPEED: float = 2.5
@export var BOB_HEIGHT: float = 5
@export var BOB_ENABLED: bool = true

@export var ExplosionParticle = preload("res://Scenes/Particles/explosion.tscn")

@export var PLAYER_MANANGER: Node

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
	else:
		position.y = ORGINAL_Y


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#print("coin collected")
		body.get_node("mananger").COINS_COLLECTED += 1
		
		var particle = ExplosionParticle.instantiate()
		get_tree().current_scene.add_child(particle)
		particle.global_position = global_position
		particle.reset_physics_interpolation()
		particle.get_node("CPUParticles2D").emitting = true
		
		queue_free() # Replace with function body.
