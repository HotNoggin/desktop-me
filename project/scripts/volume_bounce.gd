class_name VolumeBounce
extends Node

@export var input: VolumeInput
@export var target: MouseLook
@export var intensity: float = 1.0
@export var maximum_height: float = 4 # Keep positive
@export var offset: Vector2


func _process(_delta: float) -> void:
	var clamped_value: float = minf(input.current_volume * intensity, maximum_height)
	target.offset.y = -clamped_value
	target.offset += offset
	#print(input.current_volume)
