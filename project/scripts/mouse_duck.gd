class_name MouseDuck
extends Node

@export var target: Node2D
@export var radius: float = 100.0
@export var origin: Vector2 = Vector2(0,32)
@export var duck_curve: Curve
@export var duck_speed: float = 3.0
@export var duck_distance: float = 150.0
@export var home_position: Vector2 = Vector2.ZERO
@export var duck_direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	if not target:
		target = get_parent()
	#if auto_offset:
		#offset = target.position
	origin += target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dist: float = (target.get_global_mouse_position() - origin).length()
	var curve_pos: float = clamp(dist / radius, 0, 1)
	var sample: float = duck_curve.sample(curve_pos)
	var position: Vector2 = home_position + duck_direction * sample * duck_distance
	#print(position)
	#print(target.global_position)
	
	#target.position = lerp(target.position, position, delta * duck_speed)
	target.global_position = lerp(target.global_position, position, delta * duck_speed)
