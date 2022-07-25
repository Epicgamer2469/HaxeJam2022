package objects;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxSoundAsset;
import flixel.system.FlxSound;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import util.Game;

using StringTools;

class TextTyper extends FlxTypedSpriteGroup<FlxBitmapText>
{
	public var size:Int;
	public var font:String;
	public var defaultColor:FlxColor;
	public var delay:Float = 0.05;
	public var hSpacing:Float = 1;
	public var vSpacing:Float = 1;
	public var fieldWidth:Float = 0;
	public var timer:FlxTimer;
	public var tweens:Array<FlxTween> = [];
	public var typeStyle:TypeStyle = FADEUP;
	public var sounds:Array<FlxSound> = [];
	public var onComplete = () -> {};
	public var text(default, null) = '';

	var finishedText:String;
	var currentIndex:Int = -1;
	var tags:Array<{index:Int, type:TagType, value:String}> = [];
	var lineBreaks:Array<Int> = [];

	override public function new(x:Float, y:Float, FieldWidth:Float = 0, Size:Int = 8)
	{
		super(x, y);

		timer = new FlxTimer();
		size = Size;
		fieldWidth = FieldWidth;
	}

	public function resetText(newText:String)
	{
		timer.cancel();
		text = '';

		currentIndex = -1;

		for (t in 0...members.length)
		{
			members[t].destroy();
		}
		clear();
		for (t in tweens)
		{
			t.cancel();
			t.destroy();
		}
		tweens = [];

		finishedText = '';
		finishedText = newText;
		getEvents();
		getLineBreaks();

		var curLine:Int = 0;
		var curWidth:Float = 0;
		for (i in 0...finishedText.length)
		{
			var char = finishedText.charAt(i);
			final wh = getLetterSize(char);

			if (lineBreaks.indexOf(i) != -1)
			{
				curLine++;
				curWidth = 0;
			}
			var text = Game.makeText(font);
			text.text = char;
			text.color = defaultColor;
			text.setPosition(curWidth, curLine * wh.y + vSpacing);
			text.alpha = 0;
			add(text);
			curWidth += wh.x + hSpacing;
			wh.put();
		}
	}

	public function start(speed:Float = 0.05)
	{
		delay = speed;
		timer.start(speed, typeNextLetter);
	}

	function getEvents()
	{
		var eReg = new EReg('{([^}]+)}', 'g');
		tags = [];

		while (eReg.match(finishedText))
		{
			var tag = eReg.matched(1);
			var split = tag.split(':');
			var type = getTagType(split[0]);
			tags.push({index: eReg.matchedPos().pos - (type == SPEED ? 1 : 0), type: type, value: split[1]});
			finishedText = finishedText.replace('{${tag}}', '');
		}
	}

	function getLineBreaks()
	{
		var words = finishedText.split(' ');
		var currentLength:Float = 0;
		var currentString:String = '';
		lineBreaks = [];
		for (i in 0...words.length)
		{
			var wordLength = getWordWidth(words[i]);
			if (currentLength + wordLength > fieldWidth)
			{
				currentLength = 0;
				lineBreaks.push(currentString.length);
			}
			currentLength += wordLength + getLetterSize(' ').x + hSpacing;
			currentString += words[i] + ' ';
		}
	}

	function getLetterSize(l:String)
	{
		final test = Game.makeText(font);
		test.text = l;
		final size = FlxPoint.get(test.width, test.height);
		test.destroy();
		return size;
	}

	function getWordWidth(w:String)
	{
		var total:Float = 0;
		for (v in 0...w.length)
		{
			total += getLetterSize(w.charAt(v)).x + hSpacing;
		}
		return total;
	}

	function getTagType(t:String)
	{
		return switch (t.toLowerCase())
		{
			case 'w': WAIT;
			case 's': SPEED;
			case 'c': COLOR;
			default: WAIT;
		}
	}

	function typeNextLetter(tmr:FlxTimer)
	{
		if (currentIndex == finishedText.length - 1)
		{
			tmr.cancel();
			onComplete();
			return;
		}
		if (!exists)
			return;

		currentIndex++;
		FlxG.random.getObject(sounds).play();
		text += finishedText.charAt(currentIndex);
		doTextAnim(members[currentIndex]);
		timer.start(delay, typeNextLetter);

		if (tags.length > 0)
		{
			for (i in 0...tags.length)
			{
				if (tags[i].index == currentIndex)
				{
					switch (tags[i].type)
					{
						case WAIT:
							timer.cancel();
							new FlxTimer().start(Std.parseFloat(tags[i].value), tmr ->
							{
								timer.start(delay, typeNextLetter);
							});
						case SPEED:
							delay = Std.parseFloat(tags[i].value);
							tmr.time = delay;
						case COLOR:
							members[currentIndex].color = FlxColor.fromString(tags[i].value);
					}
				}
			}
		}
	}

	function doTextAnim(t:FlxBitmapText)
	{
		switch (typeStyle)
		{
			case DEFAULT:
				t.alpha = 1;
			case FADEUP:
				t.y += t.height / 5;
				tweens.push(FlxTween.tween(t, {y: t.y - t.height / 5, alpha: 1}, 0.175, {ease: FlxEase.cubeOut}));
			case FADEDOWN:
				t.y -= t.height / 5;
				tweens.push(FlxTween.tween(t, {y: t.y + t.height / 5, alpha: 0}, 0.175, {ease: FlxEase.cubeOut}));
			case FADERIGHT:
				t.x -= t.width / 5;
				tweens.push(FlxTween.tween(t, {x: t.x + t.width / 5, alpha: 1}, 0.175, {ease: FlxEase.cubeOut}));
			default:
				t.alpha = 1;
		}
	}

	override public function destroy()
	{
		timer.cancel();
		timer.destroy();
		super.destroy();
	}
}

enum TypeStyle
{
	DEFAULT;
	FADEUP;
	FADEDOWN;
	FADERIGHT;
}

enum TagType
{
	WAIT;
	SPEED;
	COLOR;
}
