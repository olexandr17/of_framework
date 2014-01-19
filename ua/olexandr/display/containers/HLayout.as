package ua.olexandr.display.containers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import ua.olexandr.display.ResizableObject;
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
	public class HLayout extends ResizableObject {
		
		private var _space:Number;
		private var _vAlign:String;
		private var _children:Array;
		
		/**
		 * 
		 * @param	space
		 * @param	vAlign
		 */
		public function HLayout(space:Number = 0, vAlign:String = 'C') {
			invalidation = false;
			
			_space = space;
			_vAlign = vAlign;
			
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