@tool
class_name MyTexture
extends Resource

enum Part {
	OUTLINE,
	BODY,
	HEAD,
	EARS,
	HAIR,
	GLASSES,
	LEFT_EYE,
	RIGHT_EYE,
	MOUTH
}

@export var outline_texture: Texture2D
@export var body_texture: Texture2D
@export var head_texture: Texture2D
@export var ears_texture: Texture2D
@export var hair_texture: Texture2D
@export var glasses_texture: Texture2D
@export var left_eye_texture: Texture2D
@export var right_eye_texture: Texture2D
@export var mouth_texture: Texture2D



func get_texture(part: Part) -> Texture2D:
	# NOTE: map inside func as exports are null when this is called (_ready() in me.gd)
	var texture_map: Dictionary = {
		Part.OUTLINE: outline_texture,
		Part.BODY: body_texture,
		Part.HEAD: head_texture,
		Part.EARS: ears_texture,
		Part.HAIR: hair_texture,
		Part.GLASSES: glasses_texture,
		Part.LEFT_EYE: left_eye_texture,
		Part.RIGHT_EYE: right_eye_texture,
		Part.MOUTH: mouth_texture,
	}
	return texture_map[part]

func all_parts() -> Array[Part]:
	var parts: Array[Part] = []
	for part: Part in Part.size():
		parts.append(part)
	return parts
