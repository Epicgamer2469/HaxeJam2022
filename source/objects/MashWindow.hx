package objects;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.ui.FlxBar;
import util.Game;

class MashWindow extends Window
{
	var mashMeter:FlxBar;
	var mashes:Int = 0;
	var sounds:Array<FlxSound> = [];

	public function new(x:Float, y:Float)
	{
		super(x, y, 'assets/images/window_mash.png');

		mashMeter = new FlxBar(5, 24, LEFT_TO_RIGHT, 50, 6, this, 'mashes', 0, 20);
		mashMeter.createColoredEmptyBar(0xFF122020);
		mashMeter.createColoredFilledBar(0xFF59C135);
		add(mashMeter);

		for (i in 1...8)
		{
			// man i use these sounds a lot
			sounds.push(FlxG.sound.load('assets/sounds/keys/key-0$i${Game.getEXT()}'));
		}
	}

	override function whenFocused()
	{
		if (FlxG.keys.justPressed.ANY)
		{
			mashes++;
			FlxG.random.getObject(sounds).play();
			if (mashes >= 20)
				exit();
		}
	}
}
