package ua.olexandr.display.preloaders {  
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ua.olexandr.display.preloader.IProgressable;
	import ua.olexandr.text.Label;
	import ua.olexandr.utils.ColorUtils;
	
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class CirclePreloader extends Sprite implements IProgressable {  
		
		private var _count:int;
		private var _timer:Timer;
		
		private var _container:Sprite;
		
		/**
		 * 
		 * @param	colorStart
		 * @param	colorEnd
		 * @param	radiusMin
		 * @param	size
		 * @param	count
		 * @param	speed
		 */
		public function CirclePreloader(colorStart:uint = 0x000000, colorEnd:uint = 0xFFFFFF, radiusMin:int = 12, size:int = 4, count:int = 10, speed:int = 50) {
			_count = count;  
			
			_container = new Sprite();
			addChild(_container);
			
			for (var i:int = 0; i < _count; i++) {
				var _color:uint = ColorUtils.ratioRGB(colorStart, colorEnd, i / _count);
				
				var _circle:Shape = drawCircle(size, _color);
				_circle.x = radiusMin + size;
				
				var _cont:Sprite = new Sprite();
				_cont.addChild(_circle);
				_cont.rotation = 360 * i / _count;
				_container.addChild(_cont);
			}
			
			
			_timer = new Timer(speed);
			
			mouseChildren = false;
			mouseEnabled = false;
		}  
		
		/**
		 * 
		 */
		public function start():void {
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
		}
		
		/**
		 * 
		 */
		public function stop():void {
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			_timer.stop();
		}
		
		/**
		 * 
		 */
		public function get percent():Number { return 0; }
		/**
		 * 
		 */
		public function set percent(value:Number):void { }
		
		
		private function timerHandler(e:TimerEvent):void {
			_container.rotation += 360 / _count;
		}  
		
		private function drawCircle(size:Number, color:uint = 0x000000):Shape {
			var _shape:Shape = new Shape();
			_shape.graphics.beginFill(color, 1);
			_shape.graphics.drawCircle(0, 0, size);
			_shape.graphics.endFill();
			return _shape;
		}
		
   }  
}  