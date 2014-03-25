package ua.olexandr.display.preloaders {  
	import flash.events.Event;
	import flash.geom.Rectangle;
	import ua.olexandr.display.FillObject;
	import ua.olexandr.tools.tweener.Easing;
	import ua.olexandr.tools.tweener.Tweener;
	
	/**
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2013
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class SlidingPreloader extends BasePreloader {  
		
		private var _color:uint;
		private var _width:int;
		private var _height:int;
		private var _space:int;
		
		public function SlidingPreloader(color:uint = 0x000000, width:int = 200, height:int = 4, space:int = 4) {
			_color = color;
			_width = width;
			_height = height;
			_space = space;
			
			super();
			
			_holder.scrollRect = new Rectangle(0, 0, _width, _height);
			_holder.x = -_width * .5;
			
			var _item:FillObject = new FillObject(_color);
			_item.roundingPosition = false;
			_item.roundingSize = false;
			_item.setSize(_width, _height);
			_holder.addChild(_item);
		}  
		
		/**
		 * 
		 */
		override public function start():void {
			if (super.show()) {
				createItem();
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		
		private function createItem(delay:Number = 0):void {
			if (_animating) {
				var _item:FillObject = new FillObject(_color);
				_item.roundingPosition = false;
				_item.roundingSize = false;
				_item.height = _height;
				_item.x = -_space;
				_holder.addChildAt(_item, 0);
				
				Tweener.addTween(_item, .2, { x:0, delay:delay, ease:Easing.none, onComplete:function():void {
					Tweener.addTween(_item, 2, { width:_width, ease:Easing.quadIn } );
					createItem(.3);
				} } );
			}
		}
		
		private function onEnterFrame(e:Event):void {
			var _len:int = _holder.numChildren;
			
			var _lineP:FillObject;
			for (var i:int = 0; i < _len; i++) {
				var _item:FillObject = _holder.getChildAt(i) as FillObject;
				if (_lineP) {
					_item.x = _lineP.x + _lineP.width + _space;
					if (_item.x >= _width) {
						Tweener.removeTweens(_item);
						_holder.removeChild(_item);
					}
				}
				
				_lineP = _item;
			}
			
			if (!_animating && _holder.numChildren < 2)
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
   }  
}  