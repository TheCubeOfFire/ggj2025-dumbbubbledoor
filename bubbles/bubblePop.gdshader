shader_type spatial;
uniform vec3 player_color;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    float dist = floor(2.50*distance(vec2(0.5),UV));
	ALBEDO = vec3(player_color );
    ALBEDO += vec3(1.0) - vec3(abs((mod(0.25 + TIME,2.0) - 1.0))) * (1.0 - dist);
	ALBEDO *= 2.0;

	ALPHA = floor(2.0*(1.0 - distance(vec2(0.5), UV)));
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
