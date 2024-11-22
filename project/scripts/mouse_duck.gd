## A script for making your [DesktopMe] hide from your cursor when it's close.
##
## When the mouse gets close to [member anchor], the [member target] will
## move in [member duck_direction] according to [member duck_curve]. 
## The max distance it will move is [member duck_distance]. [member duck_speed]
## controls how fast it will duck. Ducking only applies when the mouse is within 
## [member radius] pixels of [member anchor]. 
## [br][br]
## [b]Note:[/b] This uses [member Node2D.global_position] to control the
## [DesktopMe]'s position. I had some trouble with local coordinates as it would
## move [member target] and [member anchor] with it. Anyways, this could be
## improved to use local coords.
## [br]- Quantumplatr

class_name MouseDuck
extends Node

## The [Node2D] to be moved.
@export var target: Node2D
## The distance within [member anchor] to start applying movement.
@export var radius: float = 100.0
## The position to compare the mouse coordinates against.
## Set this in local coordinates and this script will adjust it to global
## coordinates.
## [br][br]
## [b]Example:[/b] Vector(0,32) will place the anchor at the bottom of the
## default 64x64 sprites.
@export var anchor: Vector2 = Vector2(0,32)
## The curve at which to sample how much to move the [member target].
## This is sampled using the distance the mouse is from [member anchor]
## divided by [member radius]. If the mouse is farther away than
## [member radius], the sample is capped at 1.
## [br][br]
## A curve with points (0,1) and (1,0), for the mouse exactly at [member anchor]
## and outside [member radius] respectively, is intended for this behavior.
@export var duck_curve: Curve
## Speed at which to move the actual position towards the intended position.
## This moves it at a rate independent of the mouse distance for smoother
## visuals.
@export var duck_speed: float = 3.0
## The maximum distance to duck the [member target]
@export var duck_distance: float = 150.0
## The direction in which to apply the duck.
@export var duck_direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	if not target:
		target = get_parent()
	
	# Apply anchor to global coords
	# TODO: figure out local coords
	anchor += target.global_position

func _process(delta: float) -> void:
	# Get mouse's distance from anchor
	var dist: float = (target.get_global_mouse_position() - anchor).length()
	# Get value in range [0,1] to sample curve
	var curve_pos: float = clamp(dist / radius, 0, 1)
	# Sample within curve
	var sample: float = duck_curve.sample(curve_pos)
	# Get position away from (0,0)
	# TODO: figure out local coords
	var position: Vector2 = duck_direction * sample * duck_distance
	
	# Move target towards desired position
	target.global_position = lerp(target.global_position, position, delta * duck_speed)
