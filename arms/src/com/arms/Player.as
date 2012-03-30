package com.arms 
{
	import org.flixel.*;
	
	
	public class Player extends FlxSprite
	{
		private var _numFramesBabyShaken:int;
		public var babyShakenAmount:Number;
		
		private const _MAX_FRAMES_SHAKEN:int = 20;
		private const _EXP_WARMUP_TIMESCALE:Number = 3; //units are [s]
		private const _EXP_COOLDOWN_TIMESCALE:Number = 3;
		
		private var _whenStartedWarmup:Number = 0;
		private var _whenStartedCooldown:Number = 0;
		
		private var _totalTime:Number = 0;
		
		public function Player() 
		{
			super(0,0);
			
			createGraphic(16, 16, 0xff0000ff);
			
			_numFramesBabyShaken = 0;
			babyShakenAmount = 0;
		}
		
		override public function update():void 
		{
			super.update();
			_totalTime += FlxG.elapsed;
			
			var babyShakenThisFrame:Boolean = false;
			
			if (FlxG.keys.justPressed("X"))
			{
				//SHAKE THAT BABY
				babyShakenThisFrame = true;
				//play sound here, shaking baby
			}
			
			if (babyShakenThisFrame)
			{
				_numFramesBabyShaken += 10;
				if (_numFramesBabyShaken > _MAX_FRAMES_SHAKEN)
				{
					_numFramesBabyShaken = _MAX_FRAMES_SHAKEN;
				}
			}
			else
			{
				_numFramesBabyShaken --;
				if (_numFramesBabyShaken < 0)
				{
					_numFramesBabyShaken = 0;
				}
			}
			
			FlxG.log("Frames: " + _numFramesBabyShaken);
			
			
			var amount:Number;
			if (_numFramesBabyShaken > 0)
			{
				//add to the actual baby shaken amount
				_whenStartedCooldown = 0;
				if (_whenStartedWarmup == 0)
				{
					_whenStartedWarmup = (_EXP_WARMUP_TIMESCALE * Math.log(1 - babyShakenAmount) + _totalTime);
				}
				
				babyShakenAmount = 1.0 - Math.exp( - (_totalTime - _whenStartedWarmup) / _EXP_WARMUP_TIMESCALE);
				//babyShakenAmount = Math.max(amount, babyShakenAmount); //so it starts up from where it should
			}
			else
			{
				_whenStartedWarmup = 0;
				if (_whenStartedCooldown == 0)
				{
					_whenStartedCooldown = (_EXP_WARMUP_TIMESCALE * Math.log(babyShakenAmount) + _totalTime);
				}
				
				babyShakenAmount = Math.exp( - (_totalTime - _whenStartedCooldown) / _EXP_COOLDOWN_TIMESCALE);
				//babyShakenAmount = Math.min(amount, babyShakenAmount); //so it starts up from where it should
			}
		}	
	}
}