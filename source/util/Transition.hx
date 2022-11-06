package util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Transition extends FlxTypedGroup<FlxSprite>
{
	public function new()
	{
		super();
	}

	public function open(?callback:() -> Void)
	{
		if (callback == null)
			callback = () -> {};
	}

	public function close(?callback:() -> Void)
	{
		if (callback == null)
			callback = () -> {};
	}
}
