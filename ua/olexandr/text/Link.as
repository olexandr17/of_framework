package ua.olexandr.text {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ua.olexandr.net.NetNavigator;
	import ua.olexandr.text.Label;
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public class Link extends Sprite {
		
		private var _label:Label;
		
		private var _underlined:Boolean;
		private var _overed:Boolean;
		
		private var _url:String;
		private var _target:String;
		
		/**
		 * 
		 * @param	color
		 * @param	size
		 */
		public function Link(color:uint = 0x0000FF, size:Number = 12) {
			_label = new Label(color, size);
			addChild(_label);
			
			underlined = true;
			
			mouseChildren = false;
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * 
		 * @param	url
		 * @param	target
		 */
		public function init(url:String, target:String = '_blank'):void {
			_url = url;
			_target = target;
			
			if (!_label.text)
				_label.text = _url;
		}
		
		/**
		 * 
		 */
		public function get label():Label { return _label; }
		
		/**
		 * 
		 */
		public function get underlined():Boolean { return _underlined; }
		/**
		 * 
		 */
		public function set underlined(value:Boolean):void {
			_underlined = value;
			if (_overed)	_label.underline = !_underlined;
			else			_label.underline = _underlined;
		}
		
		
		private function overHandler(e:MouseEvent):void {
			_overed = true;
			_label.underline = !_underlined;
		}
		
		private function outHandler(e:MouseEvent):void {
			_overed = false;
			_label.underline = _underlined;
		}
		
		private function clickHandler(e:MouseEvent):void {
			if (_url)
				NetNavigator.gotoURL(_url, _target);
		}
		
	}

}