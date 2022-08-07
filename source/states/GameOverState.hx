package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import util.Game;

class GameOverState extends FlxState
{
	final quips = [
		'tough day, huh?',
		'uh... maybe try downloading more RAM?',
		'have you tried turning it off and on again?',
		'quickly! pour water on your computer!',
		'should have read the fine print...',
	];

	var texts:Array<FlxBitmapText> = [];
	var score:Float;
	var canControl:Bool = false;

	public function new(score:Float = 0)
	{
		super();
		this.score = score;
	}

	override function create()
	{
		super.create();

		FlxG.sound.music.stop();
		Game.playSound('end');

		var bg = new FlxSprite(0, 0, 'assets/images/backgrounds/bsod.png');
		add(bg);

		var quip = makeText(FlxG.random.getObject(quips), 12, 87, '5px');
		var survived = makeText('time survived: ${FlxStringUtil.formatTime(score)}', 12, 94, '5px');
		var highScore = makeText('high-score: ${FlxStringUtil.formatTime(Game.save.data.highScore)}', 12, 101, '5px');
		var prompts = makeText('press r to restart\nor esc to return to menu', 12, 115, '5px');

		new FlxTimer().start(.75, tmr ->
		{
			switch (tmr.elapsedLoops)
			{
				case 1:
					Game.playSound('s1');
					add(quip);
				case 2:
					Game.playSound('s2');
					add(survived);
				case 3:
					add(highScore);
					if (Game.save.data.highScore < score)
					{
						Game.playSound('newHS');

						Game.save.data.highScore = score;
						Game.save.flush();

						highScore.text = 'high-score: ${FlxStringUtil.formatTime(Game.save.data.highScore)}';

						add(makeText('new best!', survived.x + survived.width, survived.y, '5px', 0xFFFFd541));
					}
					else Game.playSound('s3');
				case 4:
					Game.playSound('s1');
					canControl = true;
					add(prompts);
			}
		}, 4);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canControl)
		{
			if (FlxG.keys.justPressed.R)
			{
				Game.playMusic('disposal', .5);
				FlxG.camera.fade(0xFF000000, .5, false, () -> FlxG.switchState(new PlayState()));
			}
			else if (FlxG.keys.justPressed.ESCAPE)
				FlxG.camera.fade(0xFF000000, .5, false, () -> FlxG.switchState(new MenuState()));
		}
	}

	function makeText(text:String = '', x:Float = 0, y:Float = 0, font:String = '', color:FlxColor = 0xFFFFFFFF)
	{
		var txt = Game.makeText(font);
		txt.text = text;
		txt.setPosition(x + 2, y);
		txt.color = color;
		return txt;
		// return new FlxText(x, y, width, text).setFormat('assets/fonts/$font.ttf', size, color, align);
	}
}
