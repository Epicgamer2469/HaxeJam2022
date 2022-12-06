package objects;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.ui.FlxBar;
import util.Game;

class MashWindow extends Window
{
	var mashMeter:FlxBar;
	var mashes:Int = 0;
	var requiredMashes:Int;
	var sounds:Array<FlxSound> = [];

	public function new(x:Float, y:Float)
	{
		super(x, y, 'window_mash');

		requiredMashes = FlxG.random.int(10, 20);

		mashMeter = new FlxBar(5, 24, LEFT_TO_RIGHT, 50, 6, this, 'mashes', 0, requiredMashes);
		mashMeter.createColoredEmptyBar(0x0);
		mashMeter.createImageFilledBar('assets/images/windows/mash_fill.png');
		add(mashMeter);
	}

	override function whenFocused()
	{
		if (FlxG.keys.justPressed.ANY)
		{
			mashes++;
			Game.playKeySound();
			if (mashes >= requiredMashes)
				exit();
		}
	}
}
