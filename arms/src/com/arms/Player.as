package com.arms 
{
	import org.flixel.*;
	
	
	public class Player extends FlxSprite
	{
		private var _numFramesBabyShaken:int;
		public var babyShakenAmount:Number;
		
		private const _MAX_FRAMES_SHAKEN:int = 20;
		private const _EXP_WARMUP_TIMESCALE:Number = 2; //units are [s]
		private const _EXP_COOLDOWN_TIMESCALE:Number = 2;
		private const _CUTOFF:Number = 0.1;
		
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
				_numFramesBabyShaken ++;
				//_numFramesBabyShaken += 10;
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
			
			var amount:Number;
			if (_numFramesBabyShaken > 0)
			{
				var remaining:Number = 1 - babyShakenAmount;
				babyShakenAmount += remaining / 4;
				_whenStartedCooldown = 0;
			}
			else
			{
				_whenStartedWarmup = 0;
				if (_whenStartedCooldown == 0)
				{
					_whenStartedCooldown = (_EXP_WARMUP_TIMESCALE * Math.log(babyShakenAmount) + _totalTime);
				}
				
				babyShakenAmount = Math.exp( - (_totalTime - _whenStartedCooldown) / _EXP_COOLDOWN_TIMESCALE);
				if (babyShakenAmount < _CUTOFF)
				{
					babyShakenAmount = 0;	
				}
			}
		}	
	}
}