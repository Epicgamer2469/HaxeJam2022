package objects.windows;

import flixel.FlxG;

class PopUpWindow extends Window
{
	public function new(x:Float = 0, y:Float = 0)
	{
		var min:Int, max:Int;
		#if ITCH_BUILD
		min = 1;
		max = 3;
		#else
		min = 2;
		max = 3;
		#end
		super(x, y, 'window_${FlxG.random.int(min, max)}', true, FlxG.random.bool(20));
	}
}
