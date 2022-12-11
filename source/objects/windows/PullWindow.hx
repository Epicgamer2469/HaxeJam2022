package objects.windows;

import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;

class PullWindow extends Window
{
	var bar:FlxSprite;

	public function new(x:Float, y:Float)
	{
		super(x, y, 'window_pull');
		power = 7;

		bar = new FlxSprite(5, 24, 'assets/images/windows/pull_bar.png');
		add(bar);
	}

	final defaultInc:Float = 0.25;
	var pulling:Bool = false;
	var increment:Float = .025;

	override function whenFocused()
	{
		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(bar))
				pulling = true;
		}
		else if (FlxG.mouse.justReleased)
		{
			pulling = false;
			increment = defaultInc;
		}

		if (FlxG.mouse.y < bar.y)
		{
			increment = defaultInc;
		}

		if (pulling && FlxG.mouse.y > bar.y + bar.height)
		{
			increment = FlxMath.bound(increment + .02, 0, 2);
			bar.y += increment;
		}

		if (bar.y - y >= 61)
		{
			bar.y = y + 61;
			exit();
		}
	}
}
