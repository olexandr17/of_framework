package ua.olexandr.display.preloaders {
	import flash.display.Shape;
	import ua.olexandr.tools.tweener.Easing;
	import ua.olexandr.tools.tweener.Tweener;
	
	/**
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	
	public class FacebookPreloader extends BasePreloader {
		
		static private const ITERATION_TIME:Number = .3;
		
		private var _count:int;
		private var _minScale:Number;
		
		/**
		 * 
		 * @param	color		цвет
		 * @param	alpha		прозрачность
		 * @param	count		количество элементов
		 * @param	width		ширина
		 * @param	height		высота
		 * @param	space		расстояние между элементами
		 * @param	minScale	минимальное значение масштаба
		 */
		public function FacebookPreloader(color:uint = 0xEEEEEE, alpha:Number = 1, count:int = 3, width:int = 45, height:int = 25, space:int = 5, minScale:Number = .75) {
			_count = count;
			_minScale = minScale;
			
			super(false);
			
			_holder.x = -width >> 1;
			_holder.y = -height >> 1;
			
			var _itemW:Number = (width + space) / _count - space;
			var _itemX:Number = _itemW * .5;
			var _itemY:Number = height * .5;
			var _scaleStep:Number = (1 - _minScale) / (_count - 1);
			for (var i:int = 0; i < _count; i++) {
				var _item:Shape = new Shape();
				_item.graphics.beginFill(color, alpha);
				_item.graphics.drawRect(-_itemW * .5, -height * .5, _itemW, height);
				_item.graphics.endFill();
				_item.x = _itemX;
				_item.y = _itemY;
				_holder.addChild(_item);
				
				_itemX += (_itemW + space);
			}
		}
		
		
		override protected function startIn():void {
			for (var i:int = 0; i < _count; i++)
				zoom(_holder.getChildAt(i) as Shape, (ITERATION_TIME / _count) * i);
		}
		
		
		private function zoom(item:Shape, delay:Number = 0):void {
			var _z:Number = item.scaleX == 1 ? _minScale : 1;
			var _e:Function = item.scaleX == 1 ? Easing.sineOut : Easing.sineIn;
			if (_animating || _z == 1) {
				Tweener.addTween(item, ITERATION_TIME, { scaleX:_z, scaleY:_z, delay:delay, ease:_e, 
					onComplete:function():void {
						zoom(item);
					}
				} );
			}
		}
		
	}

}
