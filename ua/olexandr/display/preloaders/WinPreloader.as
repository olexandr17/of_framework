package ua.olexandr.display.preloaders {  
	import flash.display.Shape;
	import flash.display.Sprite;
	import ua.olexandr.tweener.Easing;
	import ua.olexandr.tweener.Tweener;
	
	/**
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2013
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class WinPreloader extends Sprite implements IProgressable {  
		
		private var _count:int;
		private var _shift:int;
		private var _time:Number;
		private var _delay:Number;
		
		private var _container:Sprite;
		private var _dots:Array;
		
		private var _animating:Boolean;
		private var _animateCount:int;
		
		/**
		 * 
		 * @param	color	цвет точек
		 * @param	radius	радиус точек
		 * @param	count	количество точек
		 * @param	space	расстояние между точками
		 * @param	shift	смещение от центра 
		 * @param	time	время анимации одного цикла одной точки
		 * @param	delay	задержка перед повтором анимации
		 */
		public function WinPreloader(color:uint = 0x000000, radius:int = 2, count:int = 5, space:int = 20, shift:int = 150, time:Number = .5, delay:Number = .5) {
			_count = count;  
			_shift = shift;
			_time = time;
			_delay = delay;
			
			_container = new Sprite();
			addChild(_container);
			
			_animating = false;
			_animateCount = 0;
			_dots = [];
			
			for (var i:int = 0; i < _count; i++) {
				var _item:Sprite = new Sprite();
				_item.x = space * i;
				_container.addChild(_item);
				
				var _dot:Shape = drawCircle(radius, color);
				_item.addChild(_dot);
				
				_dots[i] = _dot;
			}
			
			_container.x -= (_item.x + radius) * .5;
			
			mouseChildren = false;
			mouseEnabled = false;
		}  
		
		/**
		 * 
		 */
		public function start():void {
			var _b:Boolean = _animating == true;
			_animating = true;
			
			for (var i:int = 0; i < _count; i++) {
				_animateCount++;
				
				var _dot:Shape = _dots[i] as Shape;
				_dot.alpha = 0;
				_dot.x = -_shift;
				
				var _d:Number = (_b ? _delay : 0) + .1 * (_count - 1 - i);
				Tweener.addTween(_dot, _time, { alpha:1, x:0, delay:_d, ease:Easing.expoOut } );
				
				_d += _time;
				Tweener.addTween(_dot, _time, { alpha:0, x:_shift, delay:_d, ease:Easing.expoIn, 
					onComplete:completeHandler } );
			}
		}
		
		/**
		 * 
		 */
		public function stop():void {
			_animating = false;
		}
		
		/**
		 * 
		 */
		public function get percent():Number { return 0; }
		/**
		 * 
		 */
		public function set percent(value:Number):void { }
		
		
		private function completeHandler():void {
			_animateCount--;
			if (_animateCount == 0 && _animating)
				start();
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