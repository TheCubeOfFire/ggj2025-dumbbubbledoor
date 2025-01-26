shader_type spatial;
uniform vec3 player_color;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 newUV = vec2(8.0 * mod(UV.x,1.0/8.0) , UV.y);
    float dist = floor(3.0*distance(vec2(0.5),newUV));
	float distAlpha = floor(2.25*distance(vec2(0.5),newUV));
	ALBEDO = vec3(1.0);
    ALBEDO -= (vec3(1.0) - player_color) * (1.0 - dist);
	ALBEDO *= 2.0;
    ALPHA = (1.0 - distAlpha);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
