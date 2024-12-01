shader_type canvas_item;

// 摇晃强度
uniform float shake_intensity = 0.0;

// 摇晃速度
uniform float shake_speed = 20.0;

void vertex() {
	vec2 shake = vec2(0.0);
	if(VERTEX.y < 0.0){
		shake.x = sin(TIME * shake_speed + VERTEX.y) * shake_intensity;
	}
	VERTEX.xy += shake;
}
