package util;

import flixel.system.FlxAssets.FlxShader;
import flixel.util.FlxColor;

class GradientOverlay extends FlxShader
{
	@:glFragmentSource('
	
	#pragma header

	uniform vec3 startColor;
	uniform vec3 endColor;
	uniform float currentAngle;
	
	void main()
	{   
		vec2 uv = openfl_TextureCoordv;
		
		vec2 origin = vec2(0.5, 0.5);
		uv -= origin;
		
		float angle = radians(90.0) - radians(currentAngle) + atan(uv.y, uv.x);
	
		float len = length(uv);
		uv = vec2(cos(angle) * len, sin(angle) * len) + origin;

		vec3 grad = mix(startColor, endColor, smoothstep(0.0, 1.0, uv.x));
		vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
		gl_FragColor = vec4(color.rgb * grad.rgb, color.a);
	}
	')
	var color1(default, set):FlxColor = 0xf;
	var color2(default, set):FlxColor = 0xf;
	var angle(default, set):Float = 0;

	function set_color1(v:FlxColor)
	{
		color1 = v;
		startColor.value = [color1.redFloat, color1.greenFloat, color1.blueFloat];
		return v;
	}

	function set_color2(v:FlxColor)
	{
		color2 = v;
		startColor.value = [color2.redFloat, color2.greenFloat, color2.blueFloat];
		return v;
	}

	function set_angle(v:Float)
	{
		angle = v;
		currentAngle.value = [angle];
		return v;
	}

	public function new(c1:FlxColor, c2:FlxColor, angle:Float)
	{
		super();
		startColor.value = [c1.redFloat, c1.greenFloat, c1.blueFloat];
		endColor.value = [c2.redFloat, c2.greenFloat, c2.blueFloat];
		currentAngle.value = [angle];
	}
}
