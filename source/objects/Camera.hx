package objects;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.util.FlxAxes;

class Camera extends FlxCamera
{
	var slowDown:Float = 0;

	override public function shake(Intensity:Float = 0.05, Duration:Float = 0.5, ?OnComplete:Void->Void, Force:Bool = true, ?Axes:FlxAxes):Void
	{
		super.shake(Intensity, Duration, OnComplete, Force, Axes);
		slowDown = Intensity / (Duration / FlxG.elapsed);
	}

	override function updateShake(elapsed:Float):Void
	{
		if (_fxShakeDuration > 0)
		{
			if (_fxShakeIntensity > 0)
				_fxShakeIntensity -= slowDown;

			_fxShakeDuration -= elapsed;
			if (_fxShakeDuration <= 0)
			{
				scroll.set(-30, -30);
				angle = 0;
				if (_fxShakeComplete != null)
				{
					_fxShakeComplete();
				}
			}
			else
			{
				if (_fxShakeAxes != FlxAxes.Y)
				{
					scroll.x = -30 + FlxG.random.float(-_fxShakeIntensity, _fxShakeIntensity);
				}
				if (_fxShakeAxes != FlxAxes.X)
				{
					scroll.y = -30 + FlxG.random.float(-_fxShakeIntensity, _fxShakeIntensity);
				}
				angle = FlxG.random.float(-_fxShakeIntensity, _fxShakeIntensity);
			}
		}
	}
}
