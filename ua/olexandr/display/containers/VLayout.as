package ua.olexandr.display.containers {
	import flash.display.DisplayObject;
	import ua.olexandr.display.ResizableObject;
	import ua.olexandr.tools.display.Arranger;
	import ua.olexandr.tools.display.HAligner;
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class VLayout extends ResizableObject {
		
		private var _space:Number;
		private var _hAlign:String;
		private var _children:Array;
		
		/**
		 * 
		 * @param	space
		 * @param	hAlign
		 */
		public function VLayout(space:Number = 0, hAlign:String = 'C') {
			invalidation = false;
			
			_space = space;
			_hAlign = hAlign;
			
			_children = [];
			
			_width = 0;
			_height = 0;
		}
		
		/**
		 * 
		 */
		override public function set width(value:Number):void { }
		/**
		 * 
		 */
		override public function set height(value:Number):void { }
		
		/**
		 * 
		 */
		public function get space():Number { return _space; }
		/**
		 * 
		 */
		public function set space(value:Number):void {
			_space = value;
			invalidate();
		}
		
		/**
		 * 
		 */
		public function get hAlign():String { return _hAlign; }
		/**
		 * 
		 */
		public function set hAlign(value:String):void {
			_hAlign = value;
			invalidate();
		}
		
		/**
		 * 
		 */
		public function clear():void {
			while (numChildren)
				removeChildAt(0);
			
			_children = [];
			invalidate();
		}
		
		/**
		 * 
		 * @param	child
		 * @return
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			
			_children.push(child);
			invalidate();
			
			return child;
		}
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 */
		override public function setSize(width:Number, height:Number):void { }
		
		/**
		 * 
		 */
		override public function draw():void {
			_height = Arranger.arrangeY(_children, _space);
			
			_width = 0;
			for (var i:int = 0, _len:int = _children.length; i < _len; i++)
				_width = Math.max(_width, (_children[i] as DisplayObject).width);
			
			var _child:DisplayObject;
			switch(_hAlign) {
				case HAligner.L: {
					for each (_child in _children)
						_child.x = 0;
					break;
				}
				case HAligner.R: {
					for each (_child in _children)
						_child.x = _width - _child.width;
					break;
				}
				default: {
					for each (_child in _children)
						_child.x = (_width - _child.width) / 2;
				}
			}
			
			super.draw();
		}
		
	}

}