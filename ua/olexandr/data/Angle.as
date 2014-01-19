package {
	import ua.olexandr.utils.GeomUtils;
	
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	public class Angle {
		
		private var _degrees:Number;
		
		/**
		 * Constructor
		 * @param	value
		 */
		public function Angle(value:Number) {
			degrees = value;
		}
		
		public function get degrees():Number { return _degrees; }
		public function set degrees(value:Number):void {
			if (_degrees != value)
				_degrees = normalizeAngle(value);
		}
		
		public function get sin():Number { 
			return Math.sin(radians);
		}
		
		public function get cos():Number { 
			return Math.cos(_radians);
		}
		
		public function get radians():Number { 
			return GeomUtils.degreesToRadians(_degrees);
		}
		
	}

}