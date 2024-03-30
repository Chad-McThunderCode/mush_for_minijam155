shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = mix(color, vec4(0, 0, 1, 1), 0.5);
	//COLOR = vec4(color.rgb, color.a/2.);
	//COLOR = vec4(1. - color.rgb, color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
