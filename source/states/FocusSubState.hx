package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxBitmapText;
import flixel.tweens.FlxTween;
import util.Game;

class FocusSubState extends FlxSubState
{
	var bg:FlxSprite;
	var txt:FlxBitmapText;
	var exiting:Bool = false;

	public function new()
	{
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x8C000000);
		txt = Game.makeText('rev');
		txt.text = 'Click window to focus game';
		txt.screenCenter();
		add(bg);
		add(txt);
	}

	override public function update(elapsed:Float)
	{
		if (!exiting && FlxG.mouse.justPressed)
		{
			exiting = true;

			FlxTween.tween(bg, {alpha: 0}, .35);
			@:privateAccess
			FlxTween.tween(FlxG.mouse._cursor, {alpha: 0}, .35);
			FlxTween.tween(txt, {alpha: 0}, .35, {
				onComplete: twn ->
				{
					close();
				}
			});
		}
	}
}
