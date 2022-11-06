package objects;

import util.Game;
import flixel.FlxG;
import flixel.FlxSprite;

class Cursor extends FlxSprite
{
	public var follow:Bool = true;

	public function new()
	{
		super(0, 0, 'assets/images/cursor.png');
		scale.set(.25, .25);
		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (follow)
		{
			@:privateAccess
			setPosition(FlxG.mouse.x - 1, FlxG.mouse.y);
			if (FlxG.mouse.justPressed)
			{
				Game.playSound('click');
				loadGraphic('assets/images/cursor_grab.png');
			}
			else if (FlxG.mouse.justReleased)
			{
				loadGraphic('assets/images/cursor.png');
			}
		}
	}
}
