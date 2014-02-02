package ua.olexandr.display {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	[Event(name="resize", type="flash.events.Event")]
	[Event(name="render", type="flash.events.Event")]
	public class ResizableObject extends Sprite {
		
		/**
		 * 
		 */
		public static var invalidation:Boolean = true;
		
		/**
		 * 
		 */
		public var invalidation:Boolean = ResizableObject.invalidation;
		/**
		 * 
		 */
		public var roundingSize:Boolean = true;
		/**
		 * 
		 */
		public var roundingPosition:Boolean = true;
		
		protected var _widthPrev:Number = 0;
		protected var _heightPrev:Number = 0;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		/**
		 * 
		 */
		public function ResizableObject() {
			
		}
		
		/**
		 * 
		 * @param	x
		 * @param	y
		 */
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 */
		public function setSize(width:Number, height:Number):void {
			if (_width != width || _height != height) {
				_widthPrev = _width;
				_heightPrev = _height;
				
				_width = roundingSize ? Math.round(width) : width;
				_height = roundingSize ? Math.round(height) : height;
				
				dispatchEvent(new Event(Event.RESIZE));
				
				invalidate();
			}
		}
		
		/**
		 * 
		 */
		public function draw():void {
			
		}
		
		/**
		 * 
		 */
		override public function get width():Number { return _width; }
		/**
		 * 
		 */
		override public function set width(value:Number):void {
			setSize(value, height);
		}
		
		/**
		 * 
		 */
		override public function get height():Number { return _height; }
		/**
		 * 
		 */
		override public function set height(value:Number):void {
			setSize(width, value);
		}
		
		/**
		 * 
		 */
		override public function set x(value:Number):void {
			super.x = roundingPosition ? Math.round(value) : value;
		}
		
		/**
		 * 
		 */
		override public function set y(value:Number):void {
			super.y = roundingPosition ? Math.round(value) : value;
		}
		
		
		protected function invalidate():void {
			if (invalidation) {
				addEventListener(Event.ENTER_FRAME, invalidateHandler);
			} else {
 				draw();
				dispatchEvent(new Event(Event.RENDER));
			}
		}
		
		private function invalidateHandler(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, invalidateHandler);
			
			draw();
			dispatchEvent(new Event(Event.RENDER));
		}
		
	}
}