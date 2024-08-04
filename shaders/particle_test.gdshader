shader_type canvas_item;

uniform sampler2D lifetimeColorGradient;
uniform sampler2D overlapGradient;
uniform sampler2D blur;
uniform sampler2D tex1: repeat_enable;
uniform sampler2D tex2: repeat_enable;
uniform vec2 scroll1 = vec2(0.2, -0.3);
uniform vec2 scroll2 = vec2(0.1, -0.4);
uniform float tex2_scale = 0.5;
uniform float sharpness = 1.0;

void fragment() {
	float particleSeed = COLOR.r / (COLOR.r + COLOR.b + COLOR.g);
	
	float adjustedTime = TIME + particleSeed * 11374.293247;
	float tex1_intensity = texture(tex1, UV + adjustedTime * scroll1).r;
	float tex2_intensity = texture(tex2, tex2_scale * (UV + adjustedTime * scroll2)).r;
	float intensity = tex1_intensity * tex2_intensity;
	
	vec4 overlapColor = texture(overlapGradient, vec2(intensity * 3.5));
	vec4 lifetimeColor = texture(lifetimeColorGradient, vec2(COLOR.a));
	COLOR = lifetimeColor * overlapColor;
	COLOR.a *= min(1.0, intensity * sharpness) * texture(blur, UV).a;
}