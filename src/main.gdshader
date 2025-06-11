shader_type canvas_item;

uniform vec4 modulate_color = vec4(1.0, 1.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = tex_color * modulate_color;
}
