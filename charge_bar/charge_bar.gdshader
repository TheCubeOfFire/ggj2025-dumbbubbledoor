shader_type spatial;

uniform float charge = 0.55;
uniform vec3 color = vec3(0.25,1.0,1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    float val = floor(UV.x + charge - 0.1 * (abs(UV.y - 0.5)) + 0.01 * (sin(((((2.0 * TIME) + UV.y * 4.0)-0.5)*2.0))));
    float coord = SCREEN_UV.x - 0.5;
    ALBEDO = 100.0 * vec3(val * vec3(coord,-2.0*coord,-2.0*coord));
    ALPHA = val * floor(2.0 * (0.5 - abs(UV.y - 0.5)) * 4.0)/8.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
