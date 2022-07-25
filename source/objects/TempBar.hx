package objects;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import states.PlayState;
import util.Game;
import util.GradientOverlay;

class TempBar extends FlxGroup
{
	public var temp(default, set):Float = 0;

	var fakeTemp:Int = 0;
	var tempTween:FlxTween;

	var bar:FlxSprite;
	var txt:FlxBitmapText;

	public function new()
	{
		super();

		bar = new FlxSprite(184, 130).loadGraphic('assets/images/temp.png', true, 5, 12);
		for (i in 0...7)
			bar.animation.add('$i', [i]);
		add(bar);

		txt = Game.makeText('5px');
		txt.setPosition(196, 130);
		txt.fieldWidth = 22;
		txt.text = '0%';
		txt.alignment = CENTER;
		txt.shader = new GradientOverlay(0xcbcee0, 0xf1f2ff, 0);
		add(txt);
	}

	function set_temp(v:Float)
	{
		temp = FlxMath.bound(v, 0, 100);
		bar.animation.play('${Math.floor(FlxMath.remapToRange(temp, 0, 100, 0, 6))}');

		if (tempTween != null)
			tempTween.cancel();
		tempTween = FlxTween.tween(this, {fakeTemp: Math.floor(temp)}, .5, {
			onComplete: twn ->
			{
				txt.text = '${Math.floor(fakeTemp)}%';
				fixText();
				if (fakeTemp >= 100)
				{
					PlayState.instance.gameOver();
				}
			},
			onUpdate: twn ->
			{
				txt.text = '${Math.floor(fakeTemp)}%';
				fixText();
			}
		});

		return v;
	}

	function fixText()
	{
		if (txt.text.length == 2)
			txt.x = 196;
		if (txt.text.length == 3)
			txt.x = 193;
		else if (txt.text.length == 4)
			txt.x = 192;
	}
}
