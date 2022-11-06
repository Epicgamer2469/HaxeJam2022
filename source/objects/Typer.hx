package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import states.PlayState;
import util.Game;

class Typer extends Window
{
	final words:Array<String> = [
		'exit', 'execute', 'compute', 'analyze', 'open', 'backup', 'boot', 'data', 'compile', 'copy', 'paste', 'dynamic', 'firewall', 'host', 'login',
		'program', 'process', 'root', 'reboot', 'terminate'
	];
	final alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	var text:FlxBitmapText;
	var ghost:FlxBitmapText;
	var cursor:FlxSprite;

	var sounds:Array<FlxSound> = [];
	var index:Int = 0;

	public function new(x:Float, y:Float)
	{
		super(x, y, 'window_typing');
		power = 8;

		text = Game.makeText('8px');
		text.color = 0xff25d065;
		text.setPosition(3, 19);

		ghost = Game.makeText('8px');
		ghost.text = FlxG.random.getObject(words);
		ghost.color = 0xff19a162;
		ghost.setPosition(3, 19);

		cursor = new FlxSprite(5, 26).makeGraphic(5, 1, 0xff2fdd69);

		add(cursor);
		add(ghost);
		add(text);

		for (i in 1...8)
		{
			sounds.push(FlxG.sound.load('assets/sounds/keys/key-0$i${Game.getEXT()}'));
		}
	}

	var cTmr:Float = .5;

	override public function showItems()
	{
		super.showItems();
		for (spr in members)
		{
			if (spr is FlxBitmapText)
			{
				spr.x++;
				spr.y--;
				FlxTween.tween(spr, {y: spr.y + 1, x: spr.x - 1}, .5, {
					ease: FlxEase.quartOut
				});
			}
		};
	}

	override function update(elapsed:Float)
	{
		if (alive && text.text.length == ghost.text.length)
		{
			alive = false;
			Game.playSound('good');
			exit();
		}

		super.update(elapsed);

		if (cTmr > 0)
			cTmr -= elapsed;
		else
		{
			cTmr = .5;
			if (cursor.alpha < 1)
				cursor.alpha = 1;
			else
				cursor.alpha = 0;
		}

		if (focused)
			cursor.visible = true;
		else
			cursor.visible = false;
	}

	override function whenFocused()
	{
		if (FlxG.keys.justPressed.ANY)
		{
			var fKey = formatKey(FlxKey.toStringMap.get(FlxG.keys.firstJustPressed()), FlxG.keys.pressed.SHIFT);

			if (fKey == null)
				return;

			Game.playKeySound();
			cTmr = .5;
			if (ghost.text.charAt(index) == fKey.toLowerCase())
			{
				index++;
				text.text += fKey.toLowerCase();
				cursor.alpha = 1;
				if (index < ghost.text.length)
					cursor.x = text.x + text.width;
			}
			else
			{
				var wrong = Game.makeText('8px');
				wrong.color = 0xffe33838;
				wrong.setPosition(text.x + text.width - x - 2, 19);
				wrong.text = fKey.toLowerCase();
				add(wrong);

				PlayState.instance.heat(lossPower);
				Game.playSound('bad');

				FlxTween.tween(wrong, {y: wrong.y - 4, alpha: 0}, .5, {
					onComplete: twn ->
					{
						remove(wrong, true);
						wrong.destroy();
					}
				});
			}
		}
	}

	function formatKey(key:String, shiftHeld:Bool):Dynamic
	{
		return switch (key)
		{
			case 'COMMA': ',';
			case 'PERIOD': '.';
			case 'SLASH': '/';
			case 'BACKSLASH': '\\';
			case 'PLUS': shiftHeld ? '+' : '=';
			case 'MINUS': shiftHeld ? '_' : '-';
			case 'ONE': shiftHeld ? '!' : '1';
			case 'TWO': shiftHeld ? '@' : '2';
			case 'THREE': shiftHeld ? '#' : '3';
			case 'FOUR': shiftHeld ? '$' : '4';
			case 'FIVE': shiftHeld ? '%' : '5';
			case 'SIX': shiftHeld ? '^' : '6';
			case 'SEVEN': shiftHeld ? '&' : '7';
			case 'EIGHT': shiftHeld ? '*' : '8';
			case 'NINE': shiftHeld ? '(' : '9';
			case 'ZERO': shiftHeld ? ')' : '0';
			case 'EQUAL': shiftHeld ? '+' : '=';
			default: alphabet.indexOf(key) != -1 ? key : null;
		}
	}
}
