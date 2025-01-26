shader_type spatial;
uniform sampler2D screen_texture;
render_mode unshaded, fog_disabled;
#define ROTATEX -0.3
#define ROTATEY 0.5
#define PERIOD 5.0

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	 vec3 bubbleOilColor = abs(vec4(((MODEL_MATRIX) * vec4(CAMERA_POSITION_WORLD.xyz,1.0)).xyz,1.0) * ((MODEL_MATRIX) * (INV_VIEW_MATRIX) * vec4(VERTEX, 1.0))).xyz;

	 mat3 rotateX = mat3(vec3(1.0,0.0,0.0),
	                        vec3(0.0,cos(ROTATEX),-sin(ROTATEX)),
	                        vec3(0.0,sin(ROTATEX),cos(ROTATEX)));

    mat3 rotateY =  mat3(vec3(cos(ROTATEY),0.0,sin(ROTATEY)),
                            vec3(0.0,1.0,0.0),
                            vec3(-sin(ROTATEY),0.0,cos(ROTATEY)));

	float angleY = abs((mod(TIME/PERIOD,2.0) - 1.0));
    mat3 rotateXTime = mat3(vec3(1.0,0.0,0.0),
    vec3(0.0,cos(angleY),-sin(angleY)),
    vec3(0.0,sin(angleY),cos(angleY)));
    float angleX = abs((mod((TIME + 5.0)/PERIOD,2.0) - 1.0));
	mat3 rotateYTime =  mat3(vec3(cos(angleX),0.0,sin(angleX)),
    vec3(0.0,1.0,0.0),
    vec3(-sin(angleX),0.0,cos(angleX)));

	bubbleOilColor = bubbleOilColor * rotateYTime * rotateXTime;

    vec3 rotatedNormal = rotateX * rotateY * NORMAL;
  	float specularShine = round(pow(distance(vec3(0.0),vec3(5.0,5.0,100.0) * rotatedNormal)/138.0,2.0));
    ALBEDO = 0.5 * normalize(bubbleOilColor) + 1.25 * specularShine + 1.25 * texture(screen_texture , UV).xyz + vec3(0.0);
	// Called for every pixel the material is visible on.
}
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
