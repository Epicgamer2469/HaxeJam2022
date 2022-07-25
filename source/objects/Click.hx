package objects;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Click extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y, 'assets/images/click.png');
		FlxTween.tween(this, {alpha: 0, 'scale.x': .5, 'scale.y': .5}, .25, {
			ease: FlxEase.cubeOut,
			onComplete: twn ->
			{
				destroy();
			}
		});
	}
}
