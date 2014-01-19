package ua.olexandr.tools {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class MovementDetector extends EventDispatcher{
		
		private var _target:InteractiveObject;
		private var _timer:Timer;
		
		private var _point:Point;
		private var _detected:Boolean;
		
		/**
		 * 
		 * @param	target
		 * @param	time
		 */
		public function MovementDetector(target:InteractiveObject, time:Number = 3) {
			_target = target;
			_timer = new Timer(time * 1000, 1);
		}
		
		/**
		 * 
		 */
		public function get detected():Boolean { return _detected; }
		
		/**
		 * 
		 */
		public function start():void {
			_target.addEventListener(MouseEvent.MOUSE_MOVE, targetMoveHandler);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			targetMoveHandler(null);
		}
		
		/**
		 * 
		 */
		public function stop():void {
			if (_timer.running)
				_timer.stop();
			
			_target.removeEventListener(MouseEvent.MOUSE_MOVE, targetMoveHandler);
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		
		private function targetMoveHandler(e:MouseEvent):void {
			if (_timer.running)
				_timer.stop();
			
			_detected = false;
			
			if (_point)
				dispatchEvent(new Event(Event.CHANGE));
			
			_point = new Point(_target.mouseX, _target.mouseY);
			_timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void {
			_detected = true;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}