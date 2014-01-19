package ua.olexandr.debug.loggers {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import ua.olexandr.display.Box;
	import ua.olexandr.display.ResizableObject;
	import ua.olexandr.text.Label;
	import ua.olexandr.tools.display.Arranger;
	import ua.olexandr.utils.DisplayUtils;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class Console extends ResizableObject implements ILoggable {
		
		private const INDENT:uint = 2;
		
		private var _withTime:Boolean;
		private var _withDelta:Boolean;
		
		private var _back:Box;
		private var _container:Sprite;
		private var _mask:Box;
		
		/**
		 * 
		 * @param	withTime
		 * @param	withDelta
		 */
		public function Console(withTime:Boolean = true, withDelta:Boolean = true) {
			_withTime = withTime;
			_withDelta = withDelta;
			
			_back = new Box(0x000000, .6);
			addChild(_back);
			
			_container = new Sprite();
			_container.x = INDENT;
			_container.y = INDENT;
			addChild(_container);
			
			_mask = new Box();
			_mask.x = _container.x;
			_mask.y = _container.y;
			addChild(_mask);
			
			_container.mask = _mask;
			
			mouseChildren = false;
			mouseEnabled = false;
			
			setSize(240, 320);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function code(message:String):void {
			log(message, Label.FONT_TYPEWRITER, 0xD5D5D5);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function debug(message:String):void {
			log(message, Label.FONT_SANS, 0xE2E250);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function info(message:String):void {
			log(message, Label.FONT_SANS, 0xFFFFFF);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function warn(message:String):void {
			log(message, Label.FONT_SANS, 0x8AC0F4);
		}
		
		/**
		 * 
		 * @param	message
		 */
		public function error(message:String):void {
			log(message, Label.FONT_SANS, 0xFF7733);
		}
		
		/**
		 * 
		 */
		public function clear():void {
			while (_container.numChildren)
				_container.removeChildAt(0);
			
			draw();
		}
		
		/**
		 * 
		 */
		public function get fillColor():uint { return _back.fillColor; }
		/**
		 * 
		 */
		public function set fillColor(value:uint):void { _back.fillColor = value; }
		
		/**
		 * 
		 */
		public function get fillAlpha():Number { return _back.fillAlpha; }
		/**
		 * 
		 */
		public function set fillAlpha(value:Number):void { _back.fillAlpha = value; }
		
		
		/**
		 * 
		 */
		override public function draw():void {
			super.draw();
			
			scrollRect = new Rectangle(0, 0, _width, _height);
			
			_back.setSize(_width, _height);
			
			var _len:uint = _container.numChildren;
			for (var i:int = 0; i < _len; i++)
				(_container.getChildAt(i) as ConsoleItem).width = _width - INDENT * 2;
			
			var _h:Number = Arranger.arrangeY(DisplayUtils.getChildren(_container), -6);
			
			_container.y = Math.min(INDENT, _height - INDENT - _h);
			
			_mask.setSize(_width - INDENT * 2, _height - INDENT * 2);
		}
		
		
		public function log(message:String, font:String, color:uint):void {
			var _item:ConsoleItem = new ConsoleItem(_withTime, _withDelta, font);
			_item.print(unescape(message), color);
			
			_container.addChild(_item);
			draw();
		}
		
	}

}

import ua.olexandr.display.ResizableObject;
import ua.olexandr.text.Label;
import ua.olexandr.tools.display.Arranger;
import ua.olexandr.utils.DateUtils;
import ua.olexandr.utils.DisplayUtils;

internal class ConsoleItem extends ResizableObject {
	
	private static var _delta:Number = (new Date()).time;
	
	private var _withTime:Boolean;
	private var _withDelta:Boolean;
	
	private var _labelTime:Label;
	private var _labelDelta:Label;
	private var _labelMessage:Label;
	
	public function ConsoleItem(withTime:Boolean, withDelta:Boolean, font:String) {
		invalidation = false;
		
		_withTime = withTime;
		_withDelta = withDelta;
		
		if (_withTime) {
			_labelTime = new Label(0x45ED45, 11);
			_labelTime.autoSize = Label.AUTOSIZE_NONE;
			_labelTime.align = Label.ALIGN_RIGHT;
			_labelTime.width = 70;
			addChild(_labelTime);
			
			if (_withDelta) {
				_labelDelta = new Label(0x00CC00, 11);
				_labelDelta.autoSize = Label.AUTOSIZE_NONE;
				_labelDelta.width = 40;
				addChild(_labelDelta);
			}
		}
		
		_labelMessage = new Label(0xFFFFFF, 11);
		_labelMessage.multiline = true;
		_labelMessage.wordWrap = true;
		_labelMessage.font = font;
		addChild(_labelMessage);
	}
	
	public function print(message:String, color:uint):void {
		if (_withTime) {
			var _date:Date = new Date();
			_labelTime.text = DateUtils.getString(_date, DateUtils.HH_MM_SS_MS);
			
			if (_withDelta) {
				_labelDelta.text = (_date.time - _delta).toString();
				_delta = _date.time;
			}
		}
		
		_labelMessage.textColor = color;
		_labelMessage.text = message;
	}
	
	override public function draw():void {
		super.draw();
		
		Arranger.arrangeX(DisplayUtils.getChildren(this));
		
		_labelMessage.width = _width - _labelMessage.x;
		
		_height = Math.ceil(Math.max(_labelTime.height, _labelMessage.height));
	}
	
}
