package ua.olexandr.display.preloaders {
	
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public interface IProgressable {
		
		function start():void;
		function stop():void;
		
		function set percent(value:Number):void;
		function get percent():Number;
		
	}
	
}