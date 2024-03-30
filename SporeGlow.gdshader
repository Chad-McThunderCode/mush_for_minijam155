shader_type canvas_item;

uniform vec2 center;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void vertex() {
	// Called for every vertex the material is visible on.
}
void fragment() {
	float strength = .5-distance(UV, vec2(0.5, 0.5));
	vec4 color = vec4(texture(TEXTURE, UV));
	if(color.a < 0.01){
		COLOR = mix(vec4(1., 1., 1., 0.), vec4(1., 1., 1., 1.), strength);
	}else{
		COLOR = color;
		//COLOR = mix(color, vec4(1., 1., 1., 1.), strength);
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
