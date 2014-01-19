package ua.olexandr.data {
	
	public class Circle {
		
		public var x:Number
		public var y:Number
		public var radius:Number
		
		/**
		 * 
		 * @param	x
		 * @param	y
		 * @param	radius
		 */
		public function Circle(x:Number = 0, y:Number = 0, radius:Number = 0) {
			this.x = x;
			this.y = y;
			this.radius = radius;
		}
		
		public function get diameter():Number { return radius * 2; }
		
	}

}