shader_type spatial;
uniform sampler2D decor_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO.rgb = texture(decor_texture, UV).xyz;
	ALPHA = texture(decor_texture, UV).w;
	// Called for screen_textureevery pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
