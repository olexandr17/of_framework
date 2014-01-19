package ua.olexandr.display.preloaders {
	import flash.display.Sprite;
	import ua.olexandr.display.preloader.IProgressable;
	import ua.olexandr.utils.RandomUtils;
	
	/**
	 * ...
	 * @author wolsh (update Olexandr Fedorow)
	 */
	
	public class FillPreloader extends Sprite implements IProgressable {
		
		private var _colorBack:uint;
		private var _colorFore:uint;
		private var _radiusMax:int;
		private var _radiusMin:int;
		
		private var _percent:uint
		
		/**
		 * 
		 * @param	colorBack
		 * @param	colorFore
		 * @param	radiusMin
		 * @param	radiusMax
		 */
		public function FillPreloader(colorBack:uint = 0xEEEEEE, colorFore:uint = 0x777777, radiusMin:int = 14, radiusMax:int = 18) {
			_colorBack = colorBack;
			_colorFore = colorFore;
			_radiusMin = radiusMin;
			_radiusMax = radiusMax;
			
			rotation = -90;
			percent = 0;
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * 
		 */
		public function start():void { }
		/**
		 * 
		 */
		public function stop():void { }
		
		/**
		 * 
		 */
		public function get percent():Number { return _percent / 360; }
		/**
		 * 
		 */
		public function set percent(value:Number):void {
			_percent = (value * 360);
			while (_percent > 360)
				_percent -= 360;
			
			graphics.clear();
			
			if (_percent == 0)
				return;
			
			var _arc:Number = (_percent / 180 * Math.PI); // % (Math.PI * 2);
			var _len:Number = Math.abs(Math.ceil(_arc * 10 / Math.PI));
			
			if (_arc < 0)
				_len += 1;
				
			var _angle:Number = _arc / _len;
			
			var _ctrlOut:Number = _radiusMax / Math.cos(-_angle / 2);
			var _ctrlIn:Number = _radiusMin / Math.cos(-_angle / 2);
			
			var _startX:Number = _radiusMax * Math.cos(0);
			var _startY:Number = _radiusMax * Math.sin(0);
			
			var _endX:Number = _radiusMin * Math.cos(_arc);
			var _endY:Number = _radiusMin * Math.sin(_arc);
			
			var i:int;
			var _aOut:Number, _cOut:Number, _axOut:Number, _ayOut:Number, _cxOut:Number, _cyOut:Number;
			var _aIn:Number, _cIn:Number, _axIn:Number, _ayIn:Number, _cxIn:Number, _cyIn:Number;
			
			graphics.beginFill(_colorBack);
			graphics.drawCircle(0, 0, _radiusMin);
			graphics.drawCircle(0, 0, _radiusMax);
			graphics.endFill();
			
			graphics.beginFill(_colorFore);
			graphics.moveTo(_startX, _startY);
			for (i = 1; i < _len + 1; i++) {
				_aOut = _angle * i;
				_cOut = _aOut - _angle / 2;
				_axOut = _radiusMax * Math.cos(_aOut);
				_ayOut = _radiusMax * Math.sin(_aOut);
				_cxOut = _ctrlOut * Math.cos(_cOut);
				_cyOut = _ctrlOut * Math.sin(_cOut);
				graphics.curveTo(_cxOut, _cyOut, _axOut, _ayOut);
			}
			
			graphics.lineTo(_endX, _endY);
			for (i = 1; i < _len + 1; i++) {
				_aIn = _aOut - _angle * i;
				_cIn = _aIn + _angle / 2;
				_axIn = _radiusMin * Math.cos(_aIn);
				_ayIn = _radiusMin * Math.sin(_aIn);
				_cxIn = _ctrlIn * Math.cos(_cIn);
				_cyIn = _ctrlIn * Math.sin(_cIn);
				graphics.curveTo(_cxIn, _cyIn, _axIn, _ayIn);
			}
			
			graphics.lineTo(_startX, _startY);
			graphics.endFill();
		}
		
	}

}