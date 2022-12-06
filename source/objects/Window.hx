package objects;

import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxGraphicSource;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import states.PlayState;

class Window extends FlxSpriteGroup
{
	public var title:FlxSprite;
	public var window:FlxSprite;
	public var bouncing:Bool = false;
	public var canMove:Bool = false;
	public var power:Float = 5;
	public var lossPower:Float = 2;

	var focused:Bool = false;
	var focusSprite:FlxShapeBox;
	var shadow:FlxSprite;
	var close:FlxSprite;

	public function new(x:Float, y:Float, sprite:String, hasClose:Bool = false, bouncing:Bool = false)
	{
		super(x, y);
		this.bouncing = bouncing;

		sprite = StringTools.startsWith(sprite, 'assets/images') ? sprite : 'assets/images/windows/$sprite.png';
		window = new FlxSprite(0, 0, sprite);
		focusSprite = new FlxShapeBox(0, 0, window.width, window.height, {thickness: 1, color: FlxColor.WHITE}, 0x0);
		focusSprite.alpha = 0;

		shadow = new FlxSprite(2, 2, sprite);
		shadow.color = 0xFF000000;
		shadow.alpha = .35;

		title = new FlxSprite(0, 0).makeGraphic(Std.int(window.width), 6, 0x0);

		add(shadow);
		add(focusSprite);
		add(window);
		add(title);

		if (hasClose)
		{
			close = new FlxSprite(window.width - 8, 1, 'assets/images/button_close.png');
			add(close);
		}

		setPosition(FlxG.random.int(0, Std.int(FlxG.width - width)), FlxG.random.int(0, Std.int(FlxG.height - height - 16)));
		if (bouncing)
			velocity.set(FlxG.random.int(10, 20) * FlxG.random.int(-1, 1, [0]), FlxG.random.int(10, 20) * FlxG.random.int(-1, 1, [0]));
	}

	var moving:Bool = false;
	var startPoint:FlxPoint = FlxPoint.get();

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canMove || (alive && this == PlayState.instance.focusedWindow))
		{
			if (FlxG.mouse.justPressed)
			{
				if (close != null && FlxG.mouse.overlaps(close))
					exit();
				else
				{
					if (!focused)
						focus();
					if (!bouncing && FlxG.mouse.overlaps(title))
					{
						moving = true;
						startPoint = FlxG.mouse.getScreenPosition();
					}
				}
			}

			focused = true;

			if (moving)
			{
				final pos = FlxG.mouse.getScreenPosition();
				final oldPos = getPosition();
				x -= startPoint.x - pos.x;
				y -= startPoint.y - pos.y;
				if (x < 0 || x + window.width > FlxG.width)
					x = oldPos.x;
				if (y < 0 || y + window.height > FlxG.height)
					y = oldPos.y;
				startPoint = pos;
				oldPos.put();
			}
			else
				whenFocused();

			if (FlxG.mouse.justReleased)
				moving = false;
		}
		else
		{
			moving = false;
			focused = false;
		}

		if (bouncing)
		{
			FlxG.collide(window, PlayState.instance.bounds);
			if (window.isTouching(LEFT) || window.isTouching(RIGHT))
				velocity.x *= -1;
			if (window.isTouching(CEILING) || window.isTouching(FLOOR))
				velocity.y *= -1;
		}
	}

	function exit()
	{
		alive = false;
		hideItems();
		PlayState.instance.cool(power);
	}

	var focusTween:FlxTween;

	function focus()
	{
		if (focusTween != null)
			focusTween.cancel();
		focusSprite.alpha = 1;
		focusSprite.scale.set(1, 1);
		focusTween = FlxTween.tween(focusSprite, {alpha: 0, 'scale.x': 1.1, 'scale.y': 1.1}, .4, {ease: FlxEase.cubeOut});
	}

	public function hideItems()
	{
		for (spr in members)
		{
			setOrigins(spr);
			FlxTween.tween(spr, {alpha: 0, 'scale.x': .4, 'scale.y': .4}, .5, {
				ease: FlxEase.cubeOut,
				onComplete: twn ->
				{
					PlayState.instance.windows.remove(this, true);
					destroy();
				}
			});
		};
	}

	public function showItems()
	{
		alive = false;
		for (spr in members)
		{
			if (spr == focusSprite)
				continue;
			setOrigins(spr);
			spr.scale.set(0.75, 0.75);
			spr.alpha = 0;
			var toAlpha:Float = spr == shadow ? .35 : 1;
			FlxTween.tween(spr, {alpha: toAlpha, 'scale.x': 1, 'scale.y': 1}, .5, {
				ease: FlxEase.quartOut,
				onComplete: twn ->
				{
					alive = true;
				}
			});
		};
	}

	function whenFocused() {}

	function setOrigins(spr:FlxSprite)
	{
		if (spr != shadow && spr != window)
		{
			spr.origin.x += x + window.origin.x - (spr.x + spr.origin.x);
			spr.origin.y += y + window.origin.y - (spr.y + spr.origin.y);
		}
	}
}
