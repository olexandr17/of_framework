package ua.olexandr.debug.loggers {
	import flash.external.ExternalInterface;
	import ua.olexandr.utils.DateUtils;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class Firebug implements ILoggable {
		
		private var _withTime:Boolean;
		
		/**
		 * 
		 * @param	withTime
		 */
		public function Firebug(withTime:Boolean = true) {
			_withTime = withTime;
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function code(message:String):void {
			log("console.log", message);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function debug(message:String):void {
			log("console.debug", message);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function info(message:String):void {
			log("console.info", message);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function warn(message:String):void {
			log("console.warn", message);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function error(message:String):void {
			log("console.error", message);
		}
		
		/**
		 * 
		 */
		public function clear():void {
			log("console.clear", null);
		}
		
		
		private function log(cmd:String, message:String):void {
			if (ExternalInterface.available) {
				try {
					if (message)	ExternalInterface.call(cmd, getTime() + unescape(message));
					else			ExternalInterface.call(cmd);
				} catch (err:Error) {
					//trace(err.message);
				}
			} else {
				//trace("ExternalInterface is not available");
			}
		}
		
		private function getTime():String {
			return _withTime ? DateUtils.getString(new Date(), DateUtils.HH_MM_SS_MS) + ": " : ""
		}
		
	}

}
