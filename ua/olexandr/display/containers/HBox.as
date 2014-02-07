package ua.olexandr.display.containers {
	import flash.display.DisplayObject;
	import ua.olexandr.tools.display.Arranger;
	import ua.olexandr.tools.display.VAligner;
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class HBox extends Box {
		
		private var _vAlign:String;
		
		/**
		 * 
		 * @param	space
		 * @param	vAlign
		 */
		public function HBox(space:Number = 0, vAlign:String = 'C', children:Array = null) {
			_vAlign = vAlign;
			
			_secureKey = true;
			super(space, children);
		}
		
		/**
		 * 
		 */
		public function get vAlign():String { return _vAlign; }
		/**
		 * 
		 */
		public function set vAlign(value:String):void {
			_vAlign = value;
			invalidate();
		}
		
		/**
		 * 
		 */
		override public function draw():void {
			_width = Arranger.arrangeX(_children, _space);
			
			_height = 0;
			for (var i:int = 0, _len:int = _children.length; i < _len; i++)
				_height = Math.max(_height, (_children[i] as DisplayObject).height);
			
			var _child:DisplayObject;
			switch(_vAlign) {
				case VAligner.T: {
					for each (_child in _children)
						_child.y = 0;
					break;
				}
				case VAligner.B: {
					for each (_child in _children)
						_child.y = _height - _child.height;
					break;
				}
				default: {
					for each (_child in _children)
						_child.y = (_height - _child.height) / 2;
				}
			}
			
			super.draw();
		}
		
	}

}