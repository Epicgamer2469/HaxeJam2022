package states;

import objects.windows.TrashWindow;
import objects.windows.PullWindow;
import flixel.FlxG;
import flixel.FlxSprite;
import util.DebugManager;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.text.FlxBitmapText;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import objects.windows.ComboWindow;
import objects.windows.DoubleWindow;
import objects.windows.MashWindow;
import objects.windows.MathWindow;
import objects.windows.PopUpWindow;
import objects.TempBar;
import objects.windows.TypingWindow;
import objects.windows.Window;
import util.Game;

class PlayState extends GameState
{
	public static var instance:PlayState;

	public var windows = new FlxTypedGroup<Window>();
	public var focusedWindow:Window;
	public var bounds:FlxGroup;
	public var spawnRate:Float = 2.25;
	public var spawnTimer:FlxTimer;

	public final windowTypes:Array<Class<Window>> = [
		PopUpWindow,
		DoubleWindow,
		MathWindow,
		TypingWindow,
		MashWindow,
		ComboWindow,
		PullWindow,
		TrashWindow
	];

	final weights:Array<Float> = [1, .5, .6, .5, .35, .325, .4, .4];

	var started:Bool = false;
	var timeTxt:FlxBitmapText;
	var time:Float;
	var temperature:TempBar;
	var fanSound:FlxSound;

	override public function create()
	{
		super.create();

		instance = this;

		#if debug
		add(new DebugManager());
		#end

		bounds = Game.createCameraWall(gameCam, false, 30);
		FlxG.worldBounds.set(-30, -30, FlxG.width + 60, FlxG.width + 60);

		var bg = new FlxSprite(0, 0, 'assets/images/backgrounds/backdrop.png');
		var hud = new FlxSprite(0, 0, 'assets/images/backgrounds/hud.png');

		fanSound = Game.playSound('fan', 0);
		fanSound.looped = true;

		temperature = new TempBar();
		timeTxt = Game.makeText('8px_bold');
		timeTxt.setPosition(221, 132);
		timeTxt.fieldWidth = 38;
		timeTxt.alignment = CENTER;

		add(bounds);
		add(bg);
		add(windows);

		add(hud);
		add(temperature);
		add(timeTxt);

		FlxG.camera.fade(0xFF000000, .5, true);

		persistentUpdate = true;

		if (!Game.save.data.seenDialogue)
		{
			Game.save.data.seenDialogue = true;
			Game.save.flush();
			openSubState(new DialogueSubState());
		}
		else
			start();
	}

	override function closeSubState()
	{
		super.closeSubState();

		start();
	}

	function start()
	{
		started = true;
		if (spawnTimer == null)
			spawnTimer = new FlxTimer().start(spawnRate, spawnNext);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed)
		{
			var pressedWindow = -1;

			for (i in 0...windows.members.length)
			{
				if (FlxG.mouse.overlaps(windows.members[i].window))
				{
					pressedWindow = i;
				}
			}

			if (pressedWindow >= 0)
			{
				focusedWindow = windows.members[pressedWindow];
				windows.members.remove(focusedWindow);
				windows.members.push(focusedWindow);
			}
		}
		// else
		// focusedWindow = windows.members[windows.members.length - 1];

		super.update(elapsed);

		if (started)
		{
			time += elapsed;
			timeTxt.text = FlxStringUtil.formatTime(time);
		}
	}

	public function heat(amount:Float = 0)
	{
		if (temperature.temp > 50)
		{
			gameCam.shake(temperature.temp / 200, .5);
		}
		else
			fanSound.volume = 0;

		temperature.temp += amount;

		fanSound.volume = temperature.temp / 250;
	}

	public function cool(amount:Float = 0)
	{
		temperature.temp -= amount;
	}

	var lastWindow:Class<Window> = null;

	// Spawns the next window when the timer ends
	function spawnNext(tmr:FlxTimer)
	{
		if (spawnRate > .9)
			spawnRate -= FlxG.random.float(0.01, 0.015);
		tmr.reset(spawnRate);

		// Game.playSound('open');
		// In order to prevent repeating windows over and over
		var winClass:Class<Window> = FlxG.random.getObject(windowTypes, weights);
		while (winClass == lastWindow)
			winClass = FlxG.random.getObject(windowTypes, weights);
		lastWindow = winClass;
		final nextWindow:Window = Type.createInstance(winClass, []);
		windows.add(nextWindow);
		nextWindow.showItems();
		heat(nextWindow.power);
	}

	public function gameOver()
	{
		FlxG.switchState(new GameOverState(time));
	}
}
