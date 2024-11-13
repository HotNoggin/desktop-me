class_name VolumeInput
extends Node

@export var stream_player: AudioStreamPlayer
@export var timer: Timer

var bus_idx: int
var current_volume: float


func _ready() -> void:
	bus_idx = AudioServer.get_bus_index("Mic Input")
	timer.timeout.connect(_on_timer_timeout)


func _process(_delta: float) -> void:
	var audio_sample: float = AudioServer.get_bus_peak_volume_left_db(bus_idx, 0)
	var linear_sample: float = db_to_linear(audio_sample)
	current_volume = linear_sample


func _on_timer_timeout() -> void:
	# Hacky reset to avoid a bug where the mic starts to delay over time
	stream_player.playing = false
	await get_tree().create_timer(0.2).timeout
	stream_player.playing = true
