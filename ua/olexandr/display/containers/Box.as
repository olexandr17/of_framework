package ua.olexandr.display.containers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import ua.olexandr.display.ResizableObject;
	import ua.olexandr.tools.display.Arranger;
	import ua.olexandr.tools.display.VAligner;
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2014
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class Box extends ResizableObject {
		
		private var _space:Number;
		private var _children:Array;
		
		/**
		 * 
		 * @param	space
		 * @param	vAlign
		 */
		public function Box(space:Number = 0, children:Array = null) {
			invalidation = false;
			
			_space = space;
			
			_width = 0;
			_height = 0;
			
			_children = [];
			if (children is Array) {
				var len:int = children.length;
				for (var i:int = 0; i < len; i++) 
					addChild(children[i] as DisplayObject);
			}
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
		 * @param	width
		 * @param	height
		 */
		override public function setSize(width:Number, height:Number):void { }
		
		/**
		 * 
		 */
		override public function set width(value:Number):void { }
		/**
		 * 
		 */
		override public function set height(value:Number):void { }
		
	}

}