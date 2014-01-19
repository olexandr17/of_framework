package ua.olexandr.ui.components {
	import flash.display.DisplayObjectContainer;
	
	public class VSlider extends Slider {
		public function VSlider(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, defaultHandler:Function = null) {
			super(Slider.VERTICAL, parent, xpos, ypos, defaultHandler);
		}
	}
}