package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import objects.TextTyper;
import util.Game;

class DialogueSubState extends FlxSubState
{
	var dialogue:Array<String> = [
		"Hey,{w:.2} you're the new guy, right?{w:.45} Welcome to the team!",
		"You'll be working as a pop-up disposal manager,{w:.2} which shouldn't be too hard.",
		"Your job will be to dispose of any pop-ups that are sent your way,{w:.2} some are different from others but I'm sure you'll figure it out.",
		"Just make sure your computer doesn't overheat and you'll be fine!",
		"Now I'll close out this window so you can get to work,{w:.3} good luck!"
	];

	var bg:FlxSprite;
	var bubbles = new FlxTypedGroup<FlxSprite>();
	var texts = new FlxTypedGroup<TextTyper>();
	var curLine:Int = 0;
	var currentHeight:Float = 0;
	var canControl:Bool = false;
	var prompt:FlxSprite;

	public function new()
	{
		super();

		bg = new FlxSprite(0, 0, 'assets/images/cutscene/messaging.png');
		bg.screenCenter(X);
		add(bg);

		prompt = new FlxSprite(218, 111).loadGraphic('assets/images/cutscene/enter.png', true, 26, 12);
		prompt.animation.add('idle', [0, 1], 2, true);
		prompt.animation.play('idle');
		prompt.alpha = 0;

		add(bubbles);
		add(texts);
		add(prompt);

		nextDialogue();
	}

	public function nextDialogue()
	{
		canControl = false;
		FlxTween.tween(prompt, {alpha: 0}, .1, {ease: FlxEase.cubeOut});

		var newLine = new TextTyper(bg.x + 54, 9 + currentHeight, 180);
		newLine.hSpacing = -2;
		newLine.font = 'rev';
		newLine.color = 0xFF000000;
		newLine.sounds = Game.keySounds;
		newLine.onComplete = () ->
		{
			FlxTween.tween(prompt, {alpha: 1}, .1, {ease: FlxEase.cubeOut});
			currentHeight += newLine.height;
			canControl = true;
		}
		newLine.resetText(dialogue[0]);
		var bubble = new FlxSprite(newLine.x - 5, newLine.y).makeGraphic(Std.int(newLine.fieldWidth) + 5, Std.int(newLine.height), 0xFFFAFAFD);
		bubble.alpha = 0;
		FlxTween.tween(bubble, {x: bubble.x + 5, alpha: 1}, .3, {ease: FlxEase.cubeOut});
		bubbles.add(bubble);
		texts.add(newLine);
		newLine.start(0.05);
		dialogue.remove(dialogue[0]);
	}

	public function end()
	{
		canControl = false;
		FlxTween.tween(prompt, {alpha: 0, y: prompt.y + 300}, 1, {
			ease: FlxEase.cubeIn,
			onComplete: twn ->
			{
				close();
			}
		});
		FlxTween.tween(bg, {alpha: 0, y: bg.y + 300}, 1, {
			ease: FlxEase.cubeIn,
			onComplete: twn ->
			{
				close();
			}
		});
		for (spr in bubbles)
			FlxTween.tween(spr, {alpha: 0, y: spr.y + 300}, 1, {ease: FlxEase.cubeIn});
		for (spr in texts)
			FlxTween.tween(spr, {alpha: 0, y: spr.y + 300}, 1, {ease: FlxEase.cubeIn});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canControl && FlxG.keys.justPressed.ENTER)
		{
			if (dialogue[0] == null)
				end();
			else
				nextDialogue();
		}
	}
}
