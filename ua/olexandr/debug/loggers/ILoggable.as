package ua.olexandr.debug.loggers {
	
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public interface ILoggable {
		
		function info(message:String):void;
		
		function warn(message:String):void;
		
		function error(message:String):void;
		
		function debug(message:String):void;
		
		function code(message:String):void;
		
		function clear():void;
		
	}
	
}