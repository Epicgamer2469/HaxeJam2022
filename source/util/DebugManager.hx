package util;

import states.PlayState;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxBasic;

class DebugManager extends FlxBasic
{
	final nums:Array<FlxKey> = [ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, ZERO];

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.SHIFT)
		{
			final index = nums.indexOf(FlxG.keys.firstJustPressed());
			if (index != -1 && index < PlayState.instance.windowTypes.length)
			{
				var nextWindow = Type.createInstance(PlayState.instance.windowTypes[index], []);
				PlayState.instance.windows.add(nextWindow);
				nextWindow.showItems();
				PlayState.instance.heat(nextWindow.power);
			}

			if (FlxG.keys.justPressed.P)
			{
				PlayState.instance.spawnTimer.active = !PlayState.instance.spawnTimer.active;
			}
		}
	}
}
