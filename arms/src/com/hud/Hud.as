package com.hud 
{

	import com.arms.GameState;
	import org.flixel.*;
	public class Hud extends FlxGroup
	{
		private var _light: FlxSprite;
		private var _rage:FlxSprite;
		public function Hud() 
		{
			
			super();
			
			_light = new FlxSprite(0, 0);
			_rage = new FlxSprite(0, 10);
			_light.makeGraphic(FlxG.width, 10, 0xffff0000);	
			_rage.makeGraphic(FlxG.width, 10, 0xff0000ff);
			
			_light.scrollFactor = new FlxPoint(0, 0);
			_rage.scrollFactor = new FlxPoint(0, 0);
			
			_light.scale.x = 0.0;
			_rage.scale.x = 0.0;
			
			this.add(_light);
			this.add(_rage);
		}

		
		override public function update():void 
		{
			var gs:GameState = FlxG.state as GameState;
			
			_light.scale.x = gs._player.babyShakenAmount;
			_rage.scale.x = gs._player.babyRageAmount;

		}
		
	}

}