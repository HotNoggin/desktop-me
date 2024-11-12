@tool
class_name Circle2D
extends Node2D

@export var radius: int = 16:
	set(value):
		radius = value
		queue_redraw()
@export var color: Color = Color.WHITE:
	set(value):
		color = value
		queue_redraw()


func _draw() -> void:
	draw_circle(Vector2.ZERO, float(radius), color)
