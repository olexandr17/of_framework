package ua.olexandr.display.preloaders {  
	import flash.display.Sprite;
	import ua.olexandr.tools.tweener.Tweener;
	
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class BasePreloader extends Sprite {
		
		protected var _ratio:Number;
		protected var _animating:Boolean;
		protected var _holder:Sprite;
		
		/**
		 * 
		 */
		public function BasePreloader() {
			_animating = false;
			
			_holder = new Sprite();
			_holder.alpha = 0;
			addChild(_holder);
			
			mouseChildren = false;
			mouseEnabled = false;
		}  
		
		/**
		 * 
		 */
		public function start():void {
			show();
		}
		
		/**
		 * 
		 */
		public function stop():void {
			hide();
		}
		
		/**
		 * 
		 */
		public function get ratio():Number { 
			return _ratio;
		}
		
		/**
		 * 
		 */
		public function set ratio(value:Number):void {
			if (_ratio != value) {
				_ratio = value;
				update();
			}
		}
		
		
		protected function show():Boolean {
			if (!_animating) {
				_animating = true;
				Tweener.addTween(_holder, .3, { alpha:1 } );
				
				return true;
			}
			
			return false;
		}
		
		protected function hide():Boolean {
			if (_animating) {
				_animating = false;
				Tweener.addTween(_holder, .3, { alpha:0 } );
				
				return true;
			}
			
			return false;
		}
		
		protected function update():void {
			
		}
		
   }  
}  