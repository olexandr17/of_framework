package ua.olexandr.display.preloaders {
	import flash.display.Shape;
	import ua.olexandr.text.Label;
	import ua.olexandr.tools.tweener.Easing;
	import ua.olexandr.tools.tweener.Tweener;
	import ua.olexandr.utils.RandomUtils;
	
	/**
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	
	public class GridPreloader extends BasePreloader {
		
		static private const ITERATION_TIME:Number = .3;
		
		private var _cols:int;
		private var _rows:int;
		
		private var _path:Array;
		private var _grid:Array;
		
		/**
		 * 
		 * @param	color		цвет
		 * @param	alpha		прозрачность
		 * @param	cols		количество столбцов
		 * @param	rows		количество строк
		 * @param	width		ширина
		 * @param	height		высота
		 * @param	space		расстояние между элементами
		 */
		public function GridPreloader(color:uint = 0xEEEEEE, alpha:Number = 1, cols:int = 3, rows:int = 3, width:int = 50, height:int = 50, space:int = 1) {
			_cols = cols;
			_rows = rows;
			
			super(false);
			
			_holder.x = -width >> 1;
			_holder.y = -height >> 1;
			
			var _itemW:Number = (width + space) / _cols - space;
			var _itemH:Number = (height + space) / _rows - space;
			
			var _total:int = _rows * _cols;
			_grid = [];
			
			var _itemY:Number = _itemH * .5;
			for (var i:int = 0; i < _rows; i++) {
				var _itemX:Number = _itemW * .5;
				for (var j:int = 0; j < _cols; j++) {
					var _index:int = i * _cols + j;
					var _item:Shape;
					if (_index != (_total - _cols * 2) && _index != (_total - _cols + 1)) {
						_item = new Shape();
						_item.graphics.beginFill(color, alpha);
						_item.graphics.drawRect(-_itemW * .5, -height * .5, _itemW, _itemH);
						_item.graphics.endFill();
						_item.x = _itemX;
						_item.y = _itemY;
						_holder.addChild(_item);
					}
					_grid[_index] = { x:_itemX, y:_itemY, i:_item };
					
					_itemX += (_itemW + space);
				}
				_itemY += (_itemH + space);
			}
			
			
			_path = [];
			for (i = 0; i < _cols; i++)
				_path.push(i);
			for (i = 1; i < _rows; i++)
				_path.push(_cols * i + _cols - 1);
			for (i = _cols - 2; i >= 0; i--)
				_path.push(_cols * _rows - _cols + i);
			for (i = _rows - 2; i >= 1; i--)
				_path.push(_cols * i);
		}
		
		
		override protected function startIn():void {
			nextStep();
		}
		
		private function nextStep():void {
			if (_animating) {
				var _len:int = _path.length;
				for (var i:int = 0; i < _len; i++) {
					var _item:Shape = _grid[_path[i]].i as Shape;
					if (_item) {
						var j:int = _path[(i + 1) % _len];
						Tweener.addTween(_item, 5, { x:_grid[j].x, y:_grid[j].y } );
					}
				}
			}
		}
		
	}

}
