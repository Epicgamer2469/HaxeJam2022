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
		[FlxKey.CONTROL, FlxKey.SHIFT, FlxKey.B],
		[FlxKey.SHIFT, FlxKey.A, FlxKey.B],
		[FlxKey.SHIFT, FlxKey.G, FlxKey.A],
		[FlxKey.SHIFT, FlxKey.G, FlxKey.B]
	];

	var buttons:Array<CButton> = [];
	var sounds:Array<FlxSound> = [];

	public function new(x:Float, y:Float)
	{
		super(x, y, 'assets/images/window_hold.png');

		for (i in 1...8)
		{
			// man i use these sounds a lot
			sounds.push(FlxG.sound.load('assets/sounds/keys/key-0$i${Game.getEXT()}'));
		}

		var combo:Array<FlxKey> = FlxG.random.getObject(combos);
		var lastButton:CButton = null;
		for (i in 0...3)
		{
			var tX:Float = 0;
			trace(this.x);
			if (i > 0)
				tX = lastButton.x - this.x + lastButton.width + 7;
			var k = new CButton(3 + tX, 20, combo[i].toString().toLowerCase(), combo[i]);
			if (i < 2)
			{
				var p = new FlxSprite(k.x + k.width + 1, 23, 'assets/images/plus.png');
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
		super(x, y, 'assets/images/key_$graphic.png');
		loadGraphic('assets/images/key_$graphic.png', true, Math.floor(width / 2), 12);
		animation.add('idle', [0, 1], 0, false);
		animation.play('idle');
	}

	public function check()
	{
		if (FlxG.keys.anyPressed([key]))
		{
			animation.frameIndex = 1;
		}
		else
			animation.frameIndex = 0;
	}
}
