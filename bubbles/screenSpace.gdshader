shader_type canvas_item;
render_mode world_vertex_coords;

#define QUANTIZATION 8.0
#define DOWNSCALER 3.0

uniform sampler2D screen_texture : hint_normal;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec2 pixellatedUV = SCREEN_UV / SCREEN_PIXEL_SIZE - mod(SCREEN_UV / SCREEN_PIXEL_SIZE, DOWNSCALER);
    pixellatedUV *= SCREEN_PIXEL_SIZE;
	float centerDist = distance(SCREEN_UV,vec2(0.5,0.5));

    vec3 color = texture(screen_texture,SCREEN_UV).xyz;
    color *= color;

	COLOR.rgb = 3.0 * vec3(pow(centerDist,4.0)) + floor( color * QUANTIZATION + vec3(0.5) )/QUANTIZATION;

}

//void light() {	COLOR.rgb = ;
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
