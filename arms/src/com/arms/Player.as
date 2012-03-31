package com.arms 
{
	import flash.geom.Point;
	import org.flixel.*;
	
	
	public class Player extends FlxSprite
	{
		private var _numFramesBabyShaken:int;
		public var babyShakenAmount:Number;
		public var babyRageAmount: Number = 0;
		private var _babyRagePeak:Number = 0;
		private var _timeSinceLastShake:Number = 0;
		
		private const _MAX_FRAMES_SHAKEN:int = 20;
		private const _EXP_WARMUP_TIMESCALE:Number = 2; //units are [s]
		private const _EXP_COOLDOWN_TIMESCALE:Number = 2;
		private const _CUTOFF:Number = 0.1;
		
		private const _SPEED:Number = 120;
		
		private var _whenStartedWarmup:Number = 0;
		private var _whenStartedCooldown:Number = 0;
		
		private var _totalTime:Number = 0;
		
		public function Player() 
		{
			super(0, 0);
			kill();
			
			makeGraphic(16, 16, 0xff00ff00);
			
			_numFramesBabyShaken = 0;
			babyShakenAmount = 0;
			babyRageAmount = 0;
			
			drag.x = drag.y = 250;
		}
		
		override public function update():void 
		{
			super.update();
			
			_totalTime += FlxG.elapsed;
			
			
			//movement
			var dir:Point = new Point(0, 0);
			//X
			if (FlxG.keys.A || FlxG.keys.LEFT)
			{
				dir.x = -1;
			}
			else if (FlxG.keys.D || FlxG.keys.RIGHT)
			{
				dir.x = 1;
			}
			
			if (dir.length > 0)
			{
				dir.normalize(1);
			}
			
			//Y
			if (FlxG.keys.W || FlxG.keys.UP)
			{
				dir.y = -1;
			}
			else if (FlxG.keys.S || FlxG.keys.DOWN)
			{
				dir.y = 1;
			}
			
			if (Math.abs(dir.x) > 0)
			{
				velocity.x = _SPEED * dir.x;
			}
			
			if (Math.abs(dir.y) > 0)
			{
				velocity.y = _SPEED * dir.y;
			}
			
			
			//NOW SHAKE A BABY PLZ
			var babyShakenThisFrame:Boolean = false;
			
			if (FlxG.keys.justPressed("X"))
			{
				//SHAKE THAT BABY
				babyShakenThisFrame = true;
				_timeSinceLastShake = 0;
				//play sound here, shaking baby
			}
			else
			{
				_timeSinceLastShake += FlxG.elapsed;
			}
			
			updateBabyShake(babyShakenThisFrame);
			updateBabyRage(babyShakenThisFrame);
		}
		
		private function updateBabyRage(babyShakenThisFrame:Boolean): void
		{
			if (babyShakenThisFrame)
			{
				babyRageAmount += 0.11;
				_babyRagePeak = babyRageAmount;
			}
			else
			{
				babyRageAmount  = _babyRagePeak - _timeSinceLastShake/6;
			}
			
			
			// clamp
			babyRageAmount = Math.max(Math.min(babyRageAmount, 1), 0);
			
			
		}
		private function updateBabyShake(babyShakenThisFrame:Boolean): void
		{
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
			}
		}	
	}
}