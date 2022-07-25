package objects;

import flixel.FlxG;

class PopUp extends Window
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y, 'assets/images/window_${FlxG.random.int(1, 2)}.png', true, FlxG.random.bool(20));
	}
}
