package ua.olexandr.display.preloaders {  
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Lord_Xaoca (update Olexandr Fedorow)
	 */
	
	public class LinePreloader extends Sprite implements IPreloader {  
		
		private var _count:int;
		private var _timer:Timer;
		
		private var _percent:Number;
		
		private var _radiusMin:int;
		private var _size:int;
		private var _color:uint;
		
		/**
		 * 
		 * @param	color
		 * @param	radiusMin
		 * @param	size
		 * @param	count
		 * @param	speed
		 */
		public function LinePreloader(color:uint = 0x666666, radiusMin:int = 10, size:int = 10, count:int = 12, speed:int = 50) {
			_count = count;  
			
			_radiusMin = radiusMin;
			_size = size;
			_color = color;
			
			for (var i:int = 0; i < _count; i++) {
				var _line:Shape = drawRoundedRect(_size, _size * .4, _size * .2, _color);
				_line.x = _radiusMin;
				_line.y = -_line.height / 2;
				
				var _cont:Sprite = new Sprite();
				_cont.addChild(_line);
				_cont.alpha = .3 + .7 * i / _count;
				_cont.rotation = 360 * i / _count;
				addChild(_cont);
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
		public function get percent():Number { return _percent; }
		/**
		 * 
		 */
		public function set percent(value:Number):void { _percent = value; }
		
		
		private function timerHandler(e:TimerEvent):void {
			rotation += 360 / _count;
		}  
		
		private function drawRoundedRect(w:Number, h:Number, bevel:Number = 0, color:uint = 0x000000, alpha:Number = 1):Shape {
			var _shape:Shape = new Shape();
			_shape.graphics.beginFill(color, alpha);
			_shape.graphics.moveTo(w - bevel, h);			// начинаем с нижнего правого угла до закруления
			_shape.graphics.curveTo(w, h, w, h - bevel);	// закругляем вверх и вправо
			_shape.graphics.lineTo(w, bevel);				// рисуем прямую вверх до величины след скоса
			_shape.graphics.curveTo(w, 0, w - bevel, 0);	// закругляем вврех и влево
			_shape.graphics.lineTo(bevel, 0);				// рисуем верхнюю лини. влево до след скоса
			_shape.graphics.curveTo(0, 0, 0, bevel);		// рисуем верхний левый скос
			_shape.graphics.lineTo(0, h - bevel);			// рисуем левую сторону
			_shape.graphics.curveTo(0, h, bevel, h);		// рисуем нижний левый скос
			_shape.graphics.lineTo(w - bevel, h);			// рисуем нижнюю линию
			_shape.graphics.endFill();
			return _shape;
		}
		
   }  
}  