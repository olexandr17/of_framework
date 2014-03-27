package ua.olexandr.display.preloaders {  
	import flash.display.Sprite;
	import ua.olexandr.tools.tweener.Tweener;
	
	/**
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.2
	 */
	public class BasePreloader extends Sprite {
		
		protected var _ratio:Number;
		protected var _animating:Boolean;
		protected var _holder:Sprite;
		
		private var _fading:Boolean;
		
		/**
		 * Конструктор
		 */
		public function BasePreloader() {
			_holder = new Sprite();
			addChild(_holder);
			
			_animating = false;
			fading = true;
			
			mouseChildren = false;
			mouseEnabled = false;
		}  
		
		/**
		 * Начать работу прелоадера
		 */
		final public function start():void {
			if (show())
				startIn();
		}
		
		/**
		 * Остановить работу прелоадера
		 */
		final public function stop():void {
			hide();
		}
		
		/**
		 * Текущий прогресс
		 */
		public function get ratio():Number { 
			return _ratio;
		}
		
		/**
		 * Текущий прогресс
		 */
		public function set ratio(value:Number):void {
			if (_ratio != value) {
				_ratio = value;
				update();
			}
		}
		
		/**
		 * Автоисчезание прелоадера в неактивном состоянии
		 */
		public function get fading():Boolean {
			return _fading;
		}
		
		/**
		 * Автоисчезание прелоадера в неактивном состоянии
		 */
		public function set fading(value:Boolean):void {
			_fading = value;
			_holder.alpha = (!_fading || _animating) ? 1 : 0;
		}
		
		
		private function show():Boolean {
			if (!_animating) {
				_animating = true;
				
				if (fading)
					Tweener.addTween(_holder, .3, { alpha:1 } );
				
				return true;
			}
			
			return false;
		}
		
		private function hide():void {
			if (_animating) {
				_animating = false;
				
				if (fading)		Tweener.addTween(_holder, .3, { alpha:0, onComplete:stopIn } );
				else			stopIn();
			}
		}
		
		
		/**
		 * Метод, вызываемый при старте работы
		 */
		protected function startIn():void {
			
		}
		
		/**
		 * Метод, вызываемый после остановки работы или исчезания
		 */
		protected function stopIn():void {
			
		}
		
		/**
		 * Метод, в котором обновляется значение прогресса
		 */
		protected function update():void {
			
		}
		
   }  
}  