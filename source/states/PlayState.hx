package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import objects.Camera;
import objects.Click;
import objects.Combo;
import objects.Double;
import objects.MashWindow;
import objects.MathWindow;
import objects.PopUp;
import objects.TempBar;
import objects.Typer;
import objects.Window;
import util.Game;

class PlayState extends FlxState
{
	public static var instance:PlayState;

	public var windows = new FlxTypedGroup<Window>();
	public var focusedWindow:Window;
	public var bounds:FlxGroup;
	public var gameCam:Camera;

	final windowTypes:Array<Class<Window>> = [PopUp, Double, MathWindow, Typer, MashWindow];
	final weights:Array<Float> = [1, .25, .65, .625, .4, .4];

	var timeTxt:FlxBitmapText;
	var time:Float;
	var spawnTimer:FlxTimer;
	var spawnRate:Float = 2.75;
	var temperature:TempBar;
	var fanSound:FlxSound;

	override public function create()
	{
		super.create();

		instance = this;

		gameCam = new Camera(-30, -30, FlxG.width + 60, FlxG.height + 60);
		gameCam.scroll.set(-30, -30);
		FlxG.cameras.reset(gameCam);
		FlxCamera.defaultCameras = [gameCam];

		bounds = Game.createCameraWall(gameCam, false, 30);
		FlxG.worldBounds.set(-30, -30, FlxG.width + 60, FlxG.width + 60);

		var bg = new FlxSprite(0, 0, 'assets/images/backdrop.png');
		var hud = new FlxSprite(0, 0, 'assets/images/hud.png');

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
		if (spawnTimer == null)
			spawnTimer = new FlxTimer().start(spawnRate, spawnNext);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed)
		{
			Game.playSound('click');
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

		time += elapsed;
		timeTxt.text = FlxStringUtil.formatTime(time);
	}

	public function heat(amount:Float = 0)
	{
		if (temperature.temp > 50)
		{
			gameCam.shake(temperature.temp / 200, .5);
			fanSound.volume = temperature.temp / 200;
		}
		else
			fanSound.volume = 0;

		temperature.temp += amount;
	}

	public function cool(amount:Float = 0)
	{
		temperature.temp -= amount;
	}

	// Spawns the next window when the timer ends
	function spawnNext(tmr:FlxTimer)
	{
		if (spawnRate > .9)
			spawnRate -= FlxG.random.float(0.01, 0.015);
		tmr.reset(spawnRate);

		// Game.playSound('open');
		var nextWindow = Type.createInstance(FlxG.random.getObject(windowTypes, weights), []);
		windows.add(nextWindow);
		nextWindow.showItems();
		heat(nextWindow.power);
	}

	public function gameOver()
	{
		FlxG.switchState(new GameOverState(time));
	}
}
