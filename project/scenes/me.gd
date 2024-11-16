@tool
class_name Me
extends Node2D

@export var textures: MyTexture:
	set(value):
		textures = value
		clear_sprites()
		update_sprites()

# TODO: figure out why position exports won't update live

@export_range(-25, 5, 0.1) var eye_height: float = -11:
	set(value):
		eye_height = value
		if left_eye:
			left_eye.position.y = value
		if right_eye:
			right_eye.position.y = value

@export_range(1,20,0.1) var eye_width: float = 8:
	set(value):
		eye_width = value
		if left_eye:
			left_eye.position.x = -value
		if right_eye:
			right_eye.position.x = value

@export_range(-20,0,0.1) var glasses_height: float = -10:
	set(value):
		glasses_height = value
		if glasses:
			glasses.position.y = value


@export_range(-10, 10, 0.1) var mouth_height: float = 1:
	set(value):
		mouth_height = value
		if mouth:
			mouth.position.y = value

@export_range(-4,4,0.1) var ear_height: float = 0:
	set(value):
		ear_height = value
		if ears:
			ears.position.y = value

@onready var outline: Sprite2D = %Outline
@onready var body: Sprite2D = %Body
@onready var head: Sprite2D = %Head
@onready var ears: Sprite2D = %Ears
@onready var hair: Sprite2D = %Hair
@onready var glasses: Sprite2D = %Glasses
@onready var left_eye: Sprite2D = %LeftEye
@onready var right_eye: Sprite2D = %RightEye
@onready var mouth: Sprite2D = %Mouth


func _ready() -> void:
	clear_sprites()
	update_sprites()

func update_sprites() -> void:
	var part_map: Dictionary = {
		MyTexture.Part.OUTLINE: outline,
		MyTexture.Part.BODY: body,
		MyTexture.Part.HEAD: head,
		MyTexture.Part.EARS: ears,
		MyTexture.Part.HAIR: hair,
		MyTexture.Part.GLASSES: glasses,
		MyTexture.Part.LEFT_EYE: left_eye,
		MyTexture.Part.RIGHT_EYE: right_eye,
		MyTexture.Part.MOUTH: mouth,
	}
	for part: MyTexture.Part in textures.all_parts():
		var texture: Texture2D = textures.get_texture(part)
		if texture:
			var sprite: Sprite2D = part_map[part]
			if sprite: # TODO: why null on load? export?
				sprite.texture = texture

func clear_sprites() -> void:
	var part_map: Dictionary = {
		MyTexture.Part.OUTLINE: outline,
		MyTexture.Part.BODY: body,
		MyTexture.Part.HEAD: head,
		MyTexture.Part.EARS: ears,
		MyTexture.Part.HAIR: hair,
		MyTexture.Part.GLASSES: glasses,
		MyTexture.Part.LEFT_EYE: left_eye,
		MyTexture.Part.RIGHT_EYE: right_eye,
		MyTexture.Part.MOUTH: mouth,
	}
	for part: MyTexture.Part in textures.all_parts():
		var sprite: Sprite2D = part_map[part]
		if sprite: # TODO: why null on load? export?
			sprite.texture = null
