class_name VolumeBounce
extends Node

@export var input: VolumeInput
@export var target: MouseLook
@export var intensity: float = 100
@export var offset: Vector2


func _process(_delta: float) -> void:
	target.offset.y = -input.current_volume * intensity
	target.offset += offset
	#print(input.current_volume)
