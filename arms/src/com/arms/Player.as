package com.arms 
{
	import com.base.B2FlxSprite;
	import org.flixel.*;
	
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	
	public class Player extends B2FlxSprite
	{
		private var _inverseGravity:b2Vec2;
		public function Player() 
		{
			super(10, 10, 40, 10);
			this._body.SetCustomGravity(new b2Vec2(0, 0));
			
		}

		override protected function configure():void 
		{
			this._type = b2Body.b2_dynamicBody;
			super.configure();

			
			
		}
		override public function update():void 
		{
			super.update();
		
			//this._body.ApplyForce(inverseForce, this._body.GetWorldCenter())
			if (FlxG.keys.D)
			{
				//this._body.ApplyImpulse(new b2Vec2( -10, 0), this._body.GetWorldCenter());
				//this._body.SetLinearVelocity(new b2Vec2( 1, 0));
			}
			
		}
		
		
	}

}