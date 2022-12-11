package objects.windows;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;
import util.Game;
import flixel.FlxG;
import flixel.FlxSprite;

class TrashWindow extends Window
{
	var folder:FlxSprite;
	var folderOverlay:FlxSprite;
	var trashOverlay:FlxSprite;

	public function new(x:Float, y:Float)
	{
		super(x, y, 'window_trash');

		trashOverlay = new FlxSprite(52, 19, 'assets/images/windows/overlay.png');
		trashOverlay.visible = false;
		add(trashOverlay);

		folder = new FlxSprite(6, 24, 'assets/images/windows/folder.png');
		add(folder);

		folderOverlay = new FlxSprite(4, 19, 'assets/images/windows/overlay.png');
		folderOverlay.visible = false;
		add(folderOverlay);
	}

	var dragging:Bool = false;
	var startPos:FlxPoint = FlxPoint.get();

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(folder) && !dragging)
		{
			folderOverlay.visible = true;
		}
		else
		{
			folderOverlay.visible = false;
		}
	}

	var folderTween:FlxTween;

	override function whenFocused()
	{
		if (FlxG.mouse.overlaps(folder))
		{
			if (FlxG.mouse.justPressed)
			{
				if (folderTween != null)
					folderTween.cancel();
				dragging = true;
				startPos = FlxG.mouse.getScreenPosition();
			}
		}

		if (dragging && FlxG.mouse.pressed)
		{
			final pos = FlxG.mouse.getScreenPosition();
			final oldPos = folder.getPosition();
			folder.x -= startPos.x - pos.x;
			folder.y -= startPos.y - pos.y;
			if (folder.x < this.x + 2 || folder.x + folder.width > this.x + window.width - 2)
				folder.x = oldPos.x;
			if (folder.y < this.y + 8 || folder.y + folder.height > this.y + window.height - 2)
				folder.y = oldPos.y;
			startPos = pos;
			oldPos.put();
		}

		trashOverlay.visible = dragging && FlxG.overlap(folder, trashOverlay);

		if (FlxG.mouse.justReleased && dragging)
		{
			dragging = false;
			if (trashOverlay.visible)
			{
				folder.visible = false;
				exit();
			}
			else
			{
				if (folderTween != null)
					folderTween.cancel();
				folderTween = FlxTween.tween(folder, {x: this.x + 6, y: this.y + 24}, .5, {ease: FlxEase.cubeOut});
			}
		}
	}
}
