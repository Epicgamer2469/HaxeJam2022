package states;

import openfl.display.Shape;
import flixel.system.FlxBasePreloader;
import flash.display.*;
import flash.Lib;

@:bitmap("assets/images/loadbg.png") class BG extends BitmapData {}
@:bitmap("assets/images/loading_full.png") class LoadingFull extends BitmapData {}
@:bitmap("assets/images/loading_empty.png") class LoadingEmpty extends BitmapData {}

class Preloader extends FlxBasePreloader
{
	public function new(MinDisplayTime:Float = 2, ?AllowedURLs:Array<String>)
	{
		super(MinDisplayTime, AllowedURLs);
	}

	final w:Int = 69 * 4;
	final h:Int = 30 * 4;

	var loadEmpty:Bitmap;
	var loadFull:Bitmap;
	var loadMask:Shape;

	override function create()
	{
		this._width = Lib.current.stage.stageWidth;
		this._height = Lib.current.stage.stageHeight;

        var bg = new Bitmap(new BG(0, 0));
		bg.scaleX = bg.scaleY = 4;
		addChild(bg);

		loadEmpty = new Bitmap(new LoadingEmpty(0, 0));
		loadEmpty.smoothing = false;
		loadEmpty.scaleX = loadEmpty.scaleY = 4;
		loadEmpty.x = this._width / 2 - w / 2;
		loadEmpty.y = this._height / 2 - h / 2;
		addChild(loadEmpty);

		loadFull = new Bitmap(new LoadingFull(0, 0));
		loadFull.smoothing = false;
		loadFull.scaleX = loadFull.scaleY = 4;
		loadFull.x = loadEmpty.x;
		loadFull.y = loadEmpty.y;
		addChild(loadFull);

		loadMask = new Shape();
		loadMask.graphics.beginFill(0xFFFFFF);
		loadMask.graphics.drawRect(0, 0, w, h);
		loadMask.graphics.endFill();
		loadMask.x = loadFull.x;
		loadMask.y = loadFull.y;
		loadFull.mask = loadMask;
		addChild(loadMask);

		super.create();
	}

	override function update(percent:Float)
	{
		super.update(percent);
		// loadMask.height = h * percent;
		loadMask.y = loadFull.y + h - h * percent;
	}
}
