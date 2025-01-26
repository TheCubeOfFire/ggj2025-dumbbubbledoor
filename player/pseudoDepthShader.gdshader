shader_type spatial;
// Prevent the quad from being affected by lighting and fog. This also improves performance.
render_mode unshaded, fog_disabled;
#define DEPTH_LEVELS 4.0
#define DOWNSCALER 3.0
#define DISTANCE 0.05

uniform float downscale_value = 3.0;
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    float depth = texture(depth_texture, SCREEN_UV, 0.0).r;
    vec4 upos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth, 1.0);
    vec3 pixel_position = upos.xyz / upos.w;
    vec2 pixellatedUV = SCREEN_UV * VIEWPORT_SIZE - mod(SCREEN_UV * VIEWPORT_SIZE, downscale_value);
    pixellatedUV += vec2(downscale_value/2.0);
    pixellatedUV /= VIEWPORT_SIZE;
    vec3 screenColor = texture(screen_texture, pixellatedUV).xyz;
    float depthValueBounded = (texture(depth_texture, pixellatedUV).x - DISTANCE) * (8.0/(1.0-DISTANCE));


    depthValueBounded = floor(depthValueBounded * DEPTH_LEVELS)/DEPTH_LEVELS;

    mat2 bayerMatrixSmall = mat2(vec2(1.0,4.0), vec2(3.0,2.0));

    bayerMatrixSmall /= 4.0;
    pixellatedUV *= VIEWPORT_SIZE;
    pixellatedUV -= mod(pixellatedUV, 3.0);

    float ditherval = -0.25 + 0.5 * depthValueBounded + bayerMatrixSmall[int(mod((pixellatedUV).y, 2.0 ))][int(mod((pixellatedUV).x, 2.0))];
    vec2 outputUV = vec2(ditherval);

    ALBEDO = 0.75 * vec3(screenColor * ditherval);

    ALPHA = floor(ditherval * DEPTH_LEVELS)/DEPTH_LEVELS;
}