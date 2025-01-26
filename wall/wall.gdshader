shader_type spatial;
render_mode unshaded, specular_toon;
uniform vec3 player_color;
#define QUANTIZATION 9.0
#define PERIOD 5.0
#define ROTATEX -0.5
#define ROTATEY 0.25

void vertex() {
    float random = distance(vec3(0.0),10.0 * NODE_POSITION_WORLD);
    VERTEX += 0.01 * vec3(VERTEX * abs((mod(random + TIME,2.0) - 1.0) * 12.0));
}

void fragment() {
<<<<<<< HEAD

    vec3 bubbleOilColor = abs(vec4(((MODEL_MATRIX) * vec4(CAMERA_POSITION_WORLD.xyz,1.0)).xyz,1.0) * ((MODEL_MATRIX) * (INV_VIEW_MATRIX) * vec4(VERTEX, 1.0))).xyz;
    vec3 color = clamp(2.0*distance(vec3(0.0),(NORMAL*NORMAL*pow(NORMAL.z,2.0))) * player_color, player_color*0.5, player_color);



    mat3 rotateX = mat3(vec3(1.0,0.0,0.0),
    vec3(0.0,cos(ROTATEX),-sin(ROTATEX)),
    vec3(0.0,sin(ROTATEX),cos(ROTATEX)));
=======
>>>>>>> 8a32378 (made game look good?)

    vec3 bubbleOilColor = abs(vec4(((MODEL_MATRIX) * vec4(CAMERA_POSITION_WORLD.xyz,1.0)).xyz,1.0) * ((MODEL_MATRIX) * (INV_VIEW_MATRIX) * vec4(VERTEX, 1.0))).xyz;
    vec3 color = clamp(2.0*distance(vec3(0.0),(NORMAL*NORMAL*pow(NORMAL.z,2.0))) * player_color, player_color*0.5, player_color);


	
    mat3 rotateX = mat3(vec3(1.0,0.0,0.0), 
    vec3(0.0,cos(ROTATEX),-sin(ROTATEX)), 
    vec3(0.0,sin(ROTATEX),cos(ROTATEX)));
    
	mat3 rotateY =  mat3(vec3(cos(ROTATEY),0.0,sin(ROTATEY)),
    vec3(0.0,1.0,0.0),
    vec3(-sin(ROTATEY),0.0,cos(ROTATEY)));

	float angleY = abs((mod(TIME/PERIOD,2.0) - 1.0));
<<<<<<< HEAD
    mat3 rotateXTime = mat3(vec3(1.0,0.0,0.0),
    vec3(0.0,cos(angleY),-sin(angleY)),
=======
    mat3 rotateXTime = mat3(vec3(1.0,0.0,0.0), 
    vec3(0.0,cos(angleY),-sin(angleY)), 
>>>>>>> 8a32378 (made game look good?)
    vec3(0.0,sin(angleY),cos(angleY)));
    float angleX = abs((mod((TIME + 5.0)/PERIOD,2.0) - 1.0));
	mat3 rotateYTime =  mat3(vec3(cos(angleX),0.0,sin(angleX)),
    vec3(0.0,1.0,0.0),
    vec3(-sin(angleX),0.0,cos(angleX)));
<<<<<<< HEAD

	bubbleOilColor = bubbleOilColor * rotateYTime * rotateXTime;

    vec3 rotatedNormal = rotateX * rotateY * normalize(NORMAL);
    float specularShine = round(pow(distance(vec3(0.0),vec3(5.0,5.0,100.0) * rotatedNormal)/132.0,2.0));
    ALBEDO = specularShine + 4.0 * normalize(bubbleOilColor) / 5.0 + floor(0.1 / color * QUANTIZATION + vec3(0.5))/QUANTIZATION ;//clamp(vec3(round(player_color.x * depth * 5.0)/10.0,round(player_color.y * depth * 5.0)/5.0,round(player_color.z * depth * 5.0)/5.0), player_color/1.0, vec3(1.0));
    ALBEDO += 3.0 * vec3(1.0,-0.5,-0.5) * (SCREEN_UV.x - 0.5);
=======
	
	bubbleOilColor = bubbleOilColor * rotateYTime * rotateXTime;
	
    vec3 rotatedNormal = rotateX * rotateY * normalize(NORMAL);
    float specularShine = round(pow(distance(vec3(0.0),vec3(5.0,5.0,100.0) * rotatedNormal)/132.0,2.0));
    ALBEDO = specularShine + 4.0 * normalize(bubbleOilColor) / 5.0 + floor(0.1 / color * QUANTIZATION + vec3(0.5))/QUANTIZATION ;//clamp(vec3(round(player_color.x * depth * 5.0)/10.0,round(player_color.y * depth * 5.0)/5.0,round(player_color.z * depth * 5.0)/5.0), player_color/1.0, vec3(1.0));
    ALBEDO += 3.0 * vec3(1.0,-0.5,-0.5) * (SCREEN_UV.x - 0.5);  
>>>>>>> 8a32378 (made game look good?)
}

/*
float depth = pow(distance(0.0,abs(inverse(MODEL_MATRIX) * (INV_VIEW_MATRIX) * vec4(VERTEX, 1.0)).y),-4.0)/400.0;
	depth += pow(distance(0.0,abs(inverse(MODEL_MATRIX) *(INV_VIEW_MATRIX) * vec4(VERTEX, 1.0)).y),5.0)*75.0;
	depth += 0.5;
*/
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
