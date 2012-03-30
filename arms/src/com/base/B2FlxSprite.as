package com.base
{
    import org.flixel.*;
	import com.arms.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
    import Box2D.Common.Math.*;
 
    public class B2FlxSprite extends FlxSprite
    {
        private var ratio:Number = 30;
 
		public var _fixture:b2Fixture;
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _body:b2Body;
 
        protected var _world:b2World;
 
        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;
 
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;
 
 
        public function B2FlxSprite(X:Number, Y:Number, Width:Number, Height:Number):void
        {
            super(X,Y);
 
			var gs:GameState = FlxG.state as GameState;

            width = Width;
            height = Height;
            _world = gs._world;
			
			makeGraphic(width, height, 0xFF0000FF); 
			
			configure();
			createBody();
        }
		

		public function attach(other: B2FlxSprite, myAnchor: b2Vec2, otherAnchor: b2Vec2): void
		{
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDef.bodyA = this._body;
			jointDef.bodyB = other._body;
			
			jointDef.localAnchorA = myAnchor;
			jointDef.localAnchorB = otherAnchor;
			_world.CreateJoint(jointDef);
		}
		
		protected function configure():void
		{
		}
		
 
        override public function update():void
        {
            x = (_body.GetPosition().x * ratio) - width/2 ;
            y = (_body.GetPosition().y * ratio) - height/2;
            angle = _body.GetAngle() * (180 / Math.PI);
            super.update();
        }
 
        public function createBody():void
        {            
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width / 2) / ratio, (height / 2) / ratio);
 
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                        
            _fixDef.shape = boxShape;
			
 
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
			
            _body = _world.CreateBody(_bodyDef);
            _fixture = _body.CreateFixture(_fixDef);
			
        }
    }
}
 