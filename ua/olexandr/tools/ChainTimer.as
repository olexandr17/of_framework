package ua.olexandr.tools {
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class ChainTimer {
		
		private static var _hash:Dictionary = new Dictionary();
		
		public static function addChain(delay:uint, callbacks:Array):void {
			if (callbacks as Array && callbacks.length) {
				var _timer:Timer = new Timer(delay);
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
				
				_hash[_timer] = callbacks;
				
				_timer.start();
			}
		}
		
		
		private static function onTimer(e:TimerEvent):void {
			var _timer:Timer = e.target as Timer;
			var _callbacks:Array = _hash[_timer] as Array;
			
			var _callback:Function = _callbacks.shift() as Function;
			if (_callback is Function)
				_callback();
			
			if (_callbacks.length == 0) {
				_hash[_timer] = null;
				
				_timer.reset();
				_timer = null;
			}
		}
		
	}

}