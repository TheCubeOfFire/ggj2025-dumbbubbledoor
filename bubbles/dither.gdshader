shader_type canvas_item;

void vertex() {
    // Called for every vertex the material is visible on.
}

void fragment() {

    vec3 inColor = COLOR.rgb;
    vec3 quantized = floor(inColor * 8.0)/8.0;
    vec2 normalizedFrag = FRAGCOORD.xy*SCREEN_PIXEL_SIZE;
    normalizedFrag.y *= (SCREEN_PIXEL_SIZE.x/SCREEN_PIXEL_SIZE.y);
    normalizedFrag *= 256.0;
    mat4 bayerMatrix = mat4(vec4(0.0,8.0,2.0,10.0),
                            vec4(12.0,4.0,14.0,6.0),
                            vec4(3.0,11.0,1.0,9.0),
                            vec4(15.0,7.0,13.0,5.0));

    mat2 bayerMatrixSmall = mat2(vec2(0.0,2.0),
                                 vec2(3.0,1.0));

    bayerMatrix /= 16.0;
    bayerMatrixSmall /= 4.0;
    float bayerValue = (0.25 + (bayerMatrix[int(mod(normalizedFrag.x,4))][int(mod(normalizedFrag.y,4))]-0.5));
    float bayerValueSmall = (0.25 + (bayerMatrix[int(mod(normalizedFrag.x,2))][int(mod(normalizedFrag.y,2))]-0.5));
    vec3 outColor = vec3(round( COLOR.rgb * bayerValue * 4.0)/4.0);
    COLOR.rgb = vec3(0.0);
    // Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
