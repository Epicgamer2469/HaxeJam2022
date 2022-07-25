package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.math.FlxPoint;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import hscript.Interp;
import states.PlayState;
import util.Game;

using StringTools;

class MathWindow extends Window
{
	var buttons:Array<Button> = [];
	var question:FlxBitmapText;
	var answer:Int;

	public function new(x:Float, y:Float)
	{
		super(x, y, 'assets/images/window_math.png');
		power = 9.5;

		var correct = 0;
		var n1 = 0;
		var n2 = 0;
		var op = '';

		do
		{
			n1 = FlxG.random.int(-9, 9);
			n2 = FlxG.random.int(-9, 9);
			op = FlxG.random.getObject(['+', '-']);
			if (op == '+')
				correct = n1 + n2;
			else
				correct = n1 - n2;
		}
		while (correct < -9 || correct > 9);

		answer = FlxG.random.int(0, 2);

		var taken:Array<Int> = [];
		for (i in 0...3)
		{
			var txt:Int = 0;
			if (i == answer)
				txt = correct;
			else
			{
				do
				{
					txt = FlxG.random.int(-9, 9);
				}
				while (txt == correct || taken.contains(txt));
				taken.push(txt);
			}
			var b = new Button(9 + 16 * i, 19, txt);
			b.ID = i;
			buttons.push(b);
			add(b);
			add(b.display);
		}

		question = Game.makeText('mini');
		question.text = '$n1 $op $n2';
		question.color = 0xff122020;
		question.setPosition(Game.getCenter(question, 0, 60), 7);
		add(question);
	}

	override function whenFocused()
	{
		for (spr in buttons)
		{
			if (spr.animation.frameIndex == 1)
				spr.display.y = spr.y + 2;
			else
				spr.display.y = spr.y;

			if (FlxG.mouse.overlaps(spr))
			{
				spr.color = 0xfff7f7f7;
				if (FlxG.mouse.justPressed)
				{
					spr.animation.play('down', true);
					spr.display.y = spr.y + 2;
					if (spr.ID == answer)
					{
						alive = false;
						Game.playSound('good');
						new FlxTimer().start(0.15, tmr ->
						{
							exit();
						});
					}
					else
					{
						Game.playSound('bad');
						PlayState.instance.heat(lossPower);
					}
				}
			}
			else
				spr.color = 0xffffffff;
		}
	}
}

class Button extends FlxSprite
{
	public var display:FlxBitmapText;

	public function new(x:Float, y:Float, text:Int)
	{
		super(x, y);
		loadGraphic('assets/images/button_math.png', true, 12, 12);
		animation.add('up', [0]);
		animation.add('down', [1, 0], 2, false);

		display = Game.makeText('mini');
		display.text = Std.string(text).trim();
		display.color = 0xff000000;
		display.setPosition(x + width / 2 - display.width / 2, y);
	}
}
