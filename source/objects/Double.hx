package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import states.PlayState;

class Double extends Window
{
	var ok:Ok;

	public function new(x:Float, y:Float)
	{
		super(x, y, 'assets/images/window_big_${FlxG.random.int(1, 1)}.png', true);
		power = 8;
	}

	override function exit()
	{
		alive = false;
		ok = new Ok(window.width / 2 - 30, window.height / 2 - 15, this);
		add(ok);
		add(ok.button);
	}
}

class Ok extends FlxSprite
{
	public var button:FlxSprite;

	var parent:Window;

	public function new(x:Float, y:Float, parent:Window)
	{
		this.parent = parent;
		super(x, y, 'assets/images/window_ok.png');

		button = new FlxSprite(x + 27, y + 21, 'assets/images/button_ok.png');
	}

	override function update(elapsed:Float)
	{
		if (alive && FlxG.mouse.justPressed && parent == PlayState.instance.focusedWindow && FlxG.mouse.overlaps(button))
		{
			alive = false;
			PlayState.instance.cool(parent.power);
			parent.hideItems();
		}
	}
}
