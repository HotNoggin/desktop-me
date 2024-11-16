## A script for positioning the window.
## 
## A scene with this script as an autoload will move the window's position
## based on the set [member corner] property. The position is offset from the 
## corner the given [member offset] value.

class_name WindowPositioner
extends Node

## The corner of the current screen to place the window in.
@export var corner: Corner = CORNER_BOTTOM_LEFT:
	set(value):
		corner = value
		set_position()

## Windows offset in pixels from the specified [member corner].
@export var offset: Vector2i = Vector2i(50, 0):
	set(value):
		offset = value
		set_position()

# Set the window's position on load
func _ready() -> void:
	set_position()

## Update the window's position based on [member corner] and [member offset]
func set_position() -> void:
	# Get the current window's size
	var window_size: Vector2i = DisplayServer.window_get_size()

	# Get the current monitor's index
	var monitor_index: int = DisplayServer.window_get_current_screen()

	# Get the size of the current monitor
	var monitor_size: Vector2i = DisplayServer.screen_get_size(monitor_index)
	var monitor_position: Vector2i = DisplayServer.screen_get_position(monitor_index)

	# Calculate the new position: bottom-left corner
	var new_position: Vector2i = Vector2i.ZERO
	
	# Based on corner, get coordinates
	match corner:
		CORNER_BOTTOM_LEFT:
			new_position = Vector2i(0, monitor_size.y - window_size.y) + monitor_position
		CORNER_BOTTOM_RIGHT:
			new_position = Vector2i(monitor_size.x - window_size.x, monitor_size.y - window_size.y) + monitor_position
		CORNER_TOP_LEFT:
			new_position = Vector2i(0, 0) + monitor_position
		CORNER_TOP_RIGHT:
			new_position = Vector2i(monitor_size.x - window_size.x, 0) + monitor_position
	
	# Apply offset
	new_position += offset
	
	# Set the window's position
	DisplayServer.window_set_position(new_position)
