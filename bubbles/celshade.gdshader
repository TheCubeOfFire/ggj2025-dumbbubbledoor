shader_type spatial;
render_mode cull_front, unshaded;
uniform vec3 player_color;
#define VALUE 10.0

void vertex() {
    float random = distance(vec3(0.0),10.0 * NODE_POSITION_WORLD);
    VERTEX += 0.01 * vec3(VERTEX * abs((mod(random + TIME,2.0) - 1.0) * 12.0));
    VERTEX += 0.1 * normalize(VERTEX);
    // Called for every vertex the material is visible on.
}

void fragment() {
    ALBEDO = clamp(player_color,vec3(0.0), vec3(VALUE));
    // Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
