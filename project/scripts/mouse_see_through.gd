class_name MouseSeeThrough
extends Node

@export var target: Node2D
@export var radius: float = 50.0
@export var opacity_curve: Curve
@export var fade_speed: float = 10.0

func _ready() -> void:
	# Default to linear curve
	if !opacity_curve:
		opacity_curve = Curve.new()
		opacity_curve.add_point(Vector2.ZERO)
		opacity_curve.add_point(Vector2(1,1))
	
	if not target:
		target = get_parent()

func _process(delta: float) -> void:
	var dist: float = target.get_local_mouse_position().length()
	var curve_pos: float = clamp(dist / radius, 0, 1)
	var sample: float = opacity_curve.sample(curve_pos)
	target.modulate.a = lerp(target.modulate.a, sample, delta * fade_speed)
