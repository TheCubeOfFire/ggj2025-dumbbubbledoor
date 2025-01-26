shader_type spatial;
render_mode unshaded, fog_disabled;
#define PERIOD 1000.0
#define DOWNSCALER 3.0
uniform sampler2D screen_texture : hint_screen_texture;

void vertex() {
// Called for every vertex the material is visible on.
}

uvec2 pcg2d(uvec2 v)
{
    v = v * 1664525u + 1013904223u;

    v.x += v.y * 1664525u;
    v.y += v.x * 1664525u;

    v = v ^ (v>>16u);

    v.x += v.y * 1664525u;
    v.y += v.x * 1664525u;

    v = v ^ (v>>16u);

    return v;
}

void fragment() {

<<<<<<< HEAD
    float rotation = mod(TIME,360.0);
=======
    float rotation = mod(TIME,360.0); 
>>>>>>> 8a32378 (made game look good?)
    vec2 pixellatedUV = SCREEN_UV * VIEWPORT_SIZE - mod(SCREEN_UV * VIEWPORT_SIZE, DOWNSCALER);
    pixellatedUV /= VIEWPORT_SIZE / 20.0;
    mat3 rotZ = mat3(vec3(cos(rotation),-sin(rotation),0.0), vec3(sin(rotation),cos(rotation),0.0), vec3(0.0,0.0,1.0));
    vec3 coord = vec3(1.0,0.1,0.1);

    vec2 rotVector = (rotZ * vec3(SCREEN_UV,0.0)).xy;

    //float r = coord.x * abs((mod( rotVector.x * PERIOD + TIME,PERIOD) - PERIOD/2.0) * 1.0);
    //float g = coord.y * abs((mod( rotVector.x * PERIOD + TIME,PERIOD) - PERIOD/2.0) * 1.0);
    //float b = coord.z * abs((mod( rotVector.y * PERIOD + TIME,PERIOD) - PERIOD/2.0) * 1.0);
    float r = smoothstep(-1.0,1.0,sin(5.0 *(SCREEN_UV.y - abs((mod(TIME,PERIOD) - PERIOD/2.0) * 0.50))));
    float g = smoothstep(-1.0,1.0,sin(2.0 *(SCREEN_UV.x + abs((mod(TIME,PERIOD) - PERIOD/2.0) * 1.0))));
    float b = smoothstep(-1.0,1.0,cos(1.0 *(SCREEN_UV.y - abs((mod(TIME,PERIOD) - PERIOD/2.0) * 0.5))));

    vec3 outColor = rotZ * vec3(r,g,b);
	outColor = floor(outColor * 2.0)/2.0;
<<<<<<< HEAD

    vec2 center = VIEWPORT_SIZE / 2.0;
    ALBEDO = 0.5 * normalize(0.25 * (4.0 - (vec3(distance(center/ VIEWPORT_SIZE, SCREEN_UV)))) * normalize(0.5 * outColor + vec3(0.95)));
    ALBEDO += 3.0 * vec3(1.0,-0.5,-0.5) * (UV.x - 0.5);

=======
	
    vec2 center = VIEWPORT_SIZE / 2.0;
    ALBEDO = 0.5 * normalize(0.25 * (4.0 - (vec3(distance(center/ VIEWPORT_SIZE, SCREEN_UV)))) * normalize(0.5 * outColor + vec3(0.95)));
    ALBEDO += 3.0 * vec3(1.0,-0.5,-0.5) * (UV.x - 0.5);
    
>>>>>>> 8a32378 (made game look good?)
	// Called for every pixel the materias visible on.
}

//void light() {TIME
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
