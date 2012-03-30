package com.arms 
{
	import org.flixel.*;
	import com.base.*;
	
	/**
	 * ...
	 * @author elibrody
	 */
	public class PlayerArm extends B2FlxSprite 
	{
		
		public function PlayerArm() 
		{
			var gs:GameState = FlxG.state as GameState;
			super(10, 10, 10, 10, gs._world);
			
			
			
		}
	}

}