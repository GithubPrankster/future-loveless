shader_type canvas_item;

uniform float speed : hint_range(-1.0, 1.0) = 0.5;

void fragment()
{
	COLOR = texture(TEXTURE, vec2(UV.x, UV.y + (TIME * speed)));
}