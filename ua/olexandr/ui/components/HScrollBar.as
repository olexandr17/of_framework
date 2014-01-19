package ua.olexandr.ui.components {
	import flash.display.DisplayObjectContainer;
	
	public class HScrollBar extends ScrollBar {
		
		public function HScrollBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, defaultHandler:Function = null) {
			super(Slider.HORIZONTAL, parent, xpos, ypos, defaultHandler);
		}
		
	}
}