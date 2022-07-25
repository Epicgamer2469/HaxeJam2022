package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import states.MenuState;
import states.PlayState;
import util.Game;

class Main extends Sprite
{
	public static var starting:Bool = true;

	public function new()
	{
		super();
		addChild(new FlxGame(256, 144, MenuState, 1, 60, 60, true));

		Game.init();
		FlxG.scaleMode = new PixelPerfectScaleMode();
	}
}
