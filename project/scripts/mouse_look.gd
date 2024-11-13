class_name MouseLook
extends Node

@export var target: Node2D
@export var auto_offset: bool = true
@export var offset: Vector2
@export var max_distance: float = 3
@export_range(-1, 1) var intensity: float = 0.3


func _ready() -> void:
	if not target:
		target = get_parent()
	if auto_offset:
		offset = target.position


func _process(_delta: float) -> void:
	# The position relative to the target (the target is the origin)
	target.position = offset
	var mouse_pos: Vector2 = target.to_local(target.get_global_mouse_position())
	var set_position: Vector2 = mouse_pos * intensity
	set_position = set_position.limit_length(max_distance)
	target.position = offset + set_position
