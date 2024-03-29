﻿package gravity {		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import wck.*;	import misc.*;	import shapes.*;	import flash.utils.*;	import flash.events.*;	import flash.display.*;	import flash.text.*;	import flash.geom.*;	import flash.ui.*;		/**	 * Base class for gravity objects that can be dropped into a world. Gravity will be	 * effected by its display object transformation.	 */	public class Gravity extends Entity {		public var base:V2;		public var world:wck.World;				[Inspectable(defaultValue='')]		public var sensorName:String = '';				public override function create():void {			visible = false;			world = Util.findAncestorOfClass(this, wck.World) as wck.World;			world.ensureCreated();			if(sensorName != '') {				var sensor:ShapeBase = Util.getDisplayObjectByPath(world, sensorName, world) as ShapeBase;				if(sensor) {					sensor.reportBeginContact = true;					sensor.reportEndContact = true;					sensor.ensureCreated();					listenWhileVisible(sensor, ContactEvent.BEGIN_CONTACT, handleBeginContact);					listenWhileVisible(sensor, ContactEvent.END_CONTACT, handleEndContact);				}			}			else {				world.customGravity = this;			}			base = new V2(world.gravityX, world.gravityY);			listenWhileVisible(world, StepEvent.STEP, initStep, false, 15);		}				/**		 * When a BodyShape enters the sensor region, set it's custom gravity. The world will use		 * this gravity instead of the normal world gravity.		 * TODO: Overlapping sensor based gravity objects don't work, but are probably overkill anyway.		 */		public function handleBeginContact(e:ContactEvent):void {			var b:BodyShape = e.relatedObject as BodyShape;			b = b.body;			b.customGravity = this;		}				/**		 * Remove the custom gravity from the BodyShape on end contact.		 * TODO: compound (multi-BodyShape) bodies will get their custom gravity cleared on the first end contact. Other		 * fixtures might still be touching!		 */		public function handleEndContact(e:ContactEvent):void {			var b:BodyShape = e.relatedObject as BodyShape;			b = b.body;			b.customGravity = null;		}				/**		 *		 */		public function initStep(e:Event):void {		}				/**		 *		 */		public function gravity(p:V2, b:b2Body = null, b2:BodyShape = null):V2 {			return base;		}	}}