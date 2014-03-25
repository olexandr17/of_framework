package ua.olexandr.display.preloaders {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public class SpinnerPreloader extends Sprite implements IPreloader {
		
		private var _timer:Timer;
		private var _count:int = 0;
		
		private var _percent:Number;
		
		private var _dots:Array = [];
		private var _opacity:Array = [];
		
		/**
		 * 
		 * @param	color
		 * @param	radiusMin
		 * @param	size
		 * @param	count
		 * @param	speed
		 */
		public function SpinnerPreloader(color:uint = 0x666666, radiusMin:int = 16, size:int = 4, count:int = 12, speed:int = 50) {
			_count = count;
			
			for (var i:int = 0; i < _count; i++) {
				_opacity[i] = 1 / _count * i;
				
				var _alpha:Number = (2 * Math.PI / _count) * i - Math.PI / 2;
				
				var _dot:Shape = new Shape();
				_dot.graphics.beginFill(color);
				_dot.graphics.drawCircle(0, 0, size);
				_dot.x = radiusMin * (Math.cos(_alpha) + 1) - radiusMin;//(radiusMin - size) / 2;
				_dot.y = radiusMin * (Math.sin(_alpha) + 1) - radiusMin;//(radiusMin - size) / 2;
				addChild(_dot);
				
				_dots[i] = _dot;
			}
			
			_timer = new Timer (speed);
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * 
		 */
		public function start():void {
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
			
			for (var i:int = 0; i < _count; i++)
				_dots[i].alpha = _dots[i].scaleX = _dots[i].scaleY = _opacity[i];
		}
		
		/**
		 * 
		 */
		public function stop():void {
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			_timer.stop();
			
			for (var i:int = 0; i < _count; i++)
				_dots[i].alpha = _dots[i].scaleX = _dots[i].scaleY = 1;
		}
		
		/**
		 * 
		 */
		public function set percent(value:Number):void { _percent = value; }
		/**
		 * 
		 */
		public function get percent():Number { return _percent; }
		
		
		private function timerHandler(e:TimerEvent):void {
			_opacity.unshift(_opacity.pop());
			for (var i:int = 0; i < _count; i++)
				_dots[i].alpha = _dots[i].scaleX = _dots[i].scaleY = _opacity[i];
		}
		
	}

}