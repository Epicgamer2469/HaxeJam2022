package util;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.group.FlxGroup;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.util.FlxSave;
import openfl.Assets;

class Game
{
	public static var save = new FlxSave();

	public static function init()
	{
		save.bind('popup');

		if (save.data.highScore == null)
			save.data.highScore = 0.0;
		if (save.data.seenDialogue == null)
			save.data.seenDialogue = false;

		save.flush();
	}

	public static function playSound(sound:String, volume:Float = 1)
	{
		return FlxG.sound.play('assets/sounds/$sound${getEXT()}', volume);
	}

	public static function playMusic(sound:String, volume:Float = 1)
	{
		FlxG.sound.playMusic('assets/music/$sound${getEXT()}');
	}

	public static function getEXT()
	{
		#if desktop
		return '.ogg';
		#else
		return '.mp3';
		#end
	}

	inline public static function getCenter(text:FlxBitmapText, x:Float, width:Float)
	{
		return x + (width / 2 - text.width / 2);
	}

	// I hate web builds so much!!!
	public static function makeText(font:String)
	{
		final xml = Xml.parse(Assets.getText('assets/fonts/$font.fnt'));
		final font = FlxBitmapFont.fromAngelCode('assets/fonts/${font}_0.png', xml);

		return new FlxBitmapText(font);
	}

	// lazy
	public static function createCameraWall(Camera:FlxCamera, PlaceOutside:Bool = true, Thickness:Int, AdjustWorldBounds:Bool = false):FlxGroup
	{
		var left:FlxTileblock = null;
		var right:FlxTileblock = null;
		var top:FlxTileblock = null;
		var bottom:FlxTileblock = null;

		if (PlaceOutside)
		{
			left = new FlxTileblock(Math.floor(Camera.x - Thickness), Math.floor(Camera.y + Thickness), Thickness, Camera.height - (Thickness * 2));
			right = new FlxTileblock(Math.floor(Camera.x + Camera.width), Math.floor(Camera.y + Thickness), Thickness, Camera.height - (Thickness * 2));
			top = new FlxTileblock(Math.floor(Camera.x - Thickness), Math.floor(Camera.y - Thickness), Camera.width + Thickness * 2, Thickness);
			bottom = new FlxTileblock(Math.floor(Camera.x - Thickness), Camera.height, Camera.width + Thickness * 2, Thickness);

			if (AdjustWorldBounds)
			{
				FlxG.worldBounds.set(Camera.x - Thickness, Camera.y - Thickness, Camera.width + Thickness * 2, Camera.height + Thickness * 2);
			}
		}
		else
		{
			left = new FlxTileblock(Math.floor(Camera.x), Math.floor(Camera.y + Thickness), Thickness, Camera.height - (Thickness * 2));
			right = new FlxTileblock(Math.floor(Camera.x + Camera.width - Thickness), Math.floor(Camera.y + Thickness), Thickness,
				Camera.height - (Thickness * 2));
			top = new FlxTileblock(Math.floor(Camera.x), Math.floor(Camera.y), Camera.width, Thickness);
			bottom = new FlxTileblock(Math.floor(Camera.x), Camera.height - (Thickness * 2) - 16, Camera.width, Thickness);

			if (AdjustWorldBounds)
			{
				FlxG.worldBounds.set(Camera.x, Camera.y, Camera.width, Camera.height);
			}
		}

		var result = new FlxGroup();

		result.add(left);
		result.add(right);
		result.add(top);
		result.add(bottom);

		return result;
	}
}
