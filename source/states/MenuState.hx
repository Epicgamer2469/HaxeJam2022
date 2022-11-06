package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Window;
import util.Game;

class MenuState extends GameState
{
	var logo:FlxSprite;
	var window:PlayWindow;
	var haxejam:FlxSprite;
	var emitter1:FlxEmitter;
	var emitter2:FlxEmitter;
	var sounds:Array<FlxSound> = [];

	override function create()
	{
		super.create();

		var bg = new FlxSprite(0, 0, 'assets/images/backgrounds/menu_bg.png');
		emitter1 = new FlxEmitter(0, FlxG.height + 20);
		emitter1.launchMode = SQUARE;
		emitter1.setSize(48, 10);
		emitter1.loadParticles('assets/images/menu/circle.png', 20, 0);
		emitter1.keepScaleRatio = true;
		emitter1.scale.set(.3, .3, 1, 1);
		emitter1.velocity.set(-10, -30, 10, -50);
		emitter1.lifespan.set(6, 6);
		emitter1.start(false, 0.8);

		emitter2 = new FlxEmitter(FlxG.width - 48, FlxG.height + 20);
		emitter2.launchMode = SQUARE;
		emitter2.setSize(48, 10);
		emitter2.loadParticles('assets/images/menu/circle.png', 20, 0);
		emitter2.keepScaleRatio = true;
		emitter2.scale.set(.3, .3, 1, 1);
		emitter2.velocity.set(-10, -30, 10, -50);
		emitter2.lifespan.set(6, 6);
		emitter2.start(false, 0.8);

		logo = new FlxSprite(0, 0, 'assets/images/menu/logo.png');
		logo.scale.set(2, 2);
		logo.updateHitbox();
		logo.screenCenter();
		logo.y = -logo.height - 5;

		haxejam = new FlxSprite(0, 0, 'assets/images/menu/haxejam.png');
		haxejam.setPosition(FlxG.width - haxejam.width - 1, FlxG.height - haxejam.height - 1);
		haxejam.alpha = 0;

		window = new PlayWindow(this);

		cursor.follow = false;
		cursor.setPosition(105, FlxG.height + 2);
		cursor.loadGraphic('assets/images/cursor_grab.png');

		add(bg);
		add(emitter1);
		add(emitter2);
		add(logo);
		add(window);
		add(haxejam);

		#if html5
		if (Main.starting)
		{
			Main.starting = false;
			openSubState(new FocusSubState());
		}
		else
		{
			FlxG.camera.fade(0xFF000000, .5, true);
			start();
		}
		#else
		start();
		#end

		for (i in 1...4)
		{
			sounds.push(FlxG.sound.load('assets/sounds/pop$i${Game.getEXT()}'));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (window.canMove)
		{
			for (p in emitter1)
			{
				if (p.alive && FlxG.mouse.overlaps(p))
				{
					p.kill();

					FlxG.random.getObject(sounds).play();
				}
			}
			for (p in emitter2)
			{
				if (p.alive && FlxG.mouse.overlaps(p))
				{
					p.kill();

					FlxG.random.getObject(sounds).play();
				}
			}
		}
	}

	override function closeSubState()
	{
		super.closeSubState();
		start();
	}

	function start()
	{
		Game.playMusic('disposal', .5);

		var flags:Array<Bool> = [false, false, false];
		FlxTween.tween(haxejam, {alpha: 1}, 1);
		FlxTween.tween(logo, {y: 10}, 1.5, {
			ease: FlxEase.bounceOut,
			onUpdate: twn ->
			{
				if (twn.percent >= .35 && !flags[0])
				{
					flags[0] = true;
					Game.playSound('metal2');
				}
				else if (twn.percent >= .74 && !flags[1])
				{
					flags[1] = true;
					Game.playSound('metal1');
				}
				else if (twn.percent >= .905 && !flags[2])
				{
					flags[2] = true;
					Game.playSound('metal3');
				}
			}
		});
		FlxTween.tween(cursor, {y: 77}, .9, {ease: FlxEase.cubeOut, startDelay: .9}).then(FlxTween.tween(cursor, {y: FlxG.height + 25}, .8, {
			ease: FlxEase.cubeIn,
			startDelay: .05,
			onStart: twn ->
			{
				cursor.loadGraphic('assets/images/cursor.png');
			},
			onComplete: twn ->
			{
				window.canMove = true;
				cursor.follow = true;
				cursor.alpha = 0;
				FlxTween.tween(cursor, {alpha: 1}, .75);
			}
		}));
		FlxTween.tween(window, {y: 77}, .9, {ease: FlxEase.cubeOut, startDelay: .9});
	}
}

class PlayWindow extends Window
{
	var clicky:FlxSprite;
	var parent:MenuState;

	public function new(parent:MenuState)
	{
		this.parent = parent;
		super(x, y, 'assets/images/menu/play.png');
		setPosition(102, FlxG.height + 5);
		clicky = new FlxSprite(1, 7, 'assets/images/menu/play_mask.png');
		clicky.alpha = 0;
		add(clicky);

		shadow.x -= 4;
		shadow.alpha = .25;
		alive = false;
	}

	override function whenFocused()
	{
		if (FlxG.mouse.overlaps(clicky))
		{
			clicky.alpha = .1;
			if (FlxG.mouse.justPressed && canMove)
			{
				click();
			}
		}
		else
			clicky.alpha = 0;
	}

	public function click()
	{
		canMove = false;
		for (spr in members)
		{
			setOrigins(spr);
			FlxTween.tween(spr, {'scale.x': .9, 'scale.y': .9}, .075, {ease: FlxEase.cubeOut}).then(FlxTween.tween(spr, {'scale.x': 1, 'scale.y': 1}, .125, {
				ease: FlxEase.cubeOut,
				onComplete: twn ->
				{
					FlxG.camera.fade(0xFF000000, .5, false, () -> FlxG.switchState(new PlayState()));
				}
			}));
		}
	}
}
