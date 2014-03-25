package ua.olexandr.display.preloaders {
	
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public interface IPreloader {
		
		function start():void;
		function stop():void;
		
		function set percent(value:Number):void;
		function get percent():Number;
		
	}
	
}