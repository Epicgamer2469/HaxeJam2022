package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.ui.FlxBar;
import util.Game;

class Combo extends Window
{
	final combos:Array<Array<FlxKey>> = [
		[FlxKey.G, FlxKey.A, FlxKey.B],
		[FlxKey.Z, FlxKey.Y, FlxKey.M],
		[FlxKey.W, FlxKey.Y, FlxKey.S],
		[FlxKey.G, FlxKey.A, FlxKey.X],
		[FlxKey.M, FlxKey.A, FlxKey.B],
		[FlxKey.X, FlxKey.A, FlxKey.W],
		[FlxKey.B, FlxKey.A, FlxKey.M]
	];

	var buttons:Array<CButton> = [];

	public function new(x:Float, y:Float)
	{
		super(x, y, 'window_hold');

		var combo:Array<FlxKey> = FlxG.random.getObject(combos);
		var lastButton:CButton = null;
		for (i in 0...3)
		{
			var k = new CButton(10 + 24 * i, 20, combo[i].toString().toLowerCase(), combo[i]);
			if (i < 2)
			{
				var p = new FlxSprite(25 + 24 * i, 23, 'assets/images/plus.png');
				add(p);
			}
			k.ID = i;
			buttons.push(k);
			lastButton = k;
			add(k);
		}
	}

	var checks = [];

	override function whenFocused()
	{
		for (b in buttons)
		{
			b.check();
			checks[b.ID] = b.animation.frameIndex;
		}

		if (checks[0] + checks[1] + checks[2] == 3)
		{
			exit();
		}
	}
}

class CButton extends FlxSprite
{
	var key:FlxKey;

	public function new(x:Float, y:Float, graphic:String, key:FlxKey)
	{
		this.key = key;
		super(x, y, 'assets/images/keys/key_$graphic.png');
		loadGraphic('assets/images/keys/key_$graphic.png', true, Math.floor(width / 2), 12);
		animation.add('idle', [0, 1], 0, false);
		animation.play('idle');
	}

	public function check()
	{
		if (FlxG.keys.anyJustPressed([key]))
			Game.playKeySound();
		if (FlxG.keys.anyPressed([key]))
		{
			animation.frameIndex = 1;
		}
		else
			animation.frameIndex = 0;
	}
}
