package ua.olexandr.utils {
	import flash.geom.Point;
	import ua.olexandr.data.Circle;
	
	public class CollisionUtils {
		
		/**
		 * пересекаются ли два круга
		 */
		public static function circleToCircle(c1:Circle, c2:Circle):Boolean {
			return (c1.radius + c2.radius) * (c1.radius + c2.radius) <=
				((c1.x - c2.x) * (c1.x - c2.x)) + ((c1.y - c2.y) * (c1.y - c2.y));
		}
		
		/**
		 * пересекаются ли точка с кругом
		 */
		public static function pointToCircle(point:Point, circle:Circle):Boolean {
			return (circle.radius * circle.radius) >
				(point.x - circle.x) * (point.x - circle.x) + (point.y - circle.y) * (point.y - circle.y);
		}
		
		/**
		 * пересекаются ли две линии 
		 */
		public static function lineToLine(p11:Point, p12:Point, p21:Point, p22:Point):Boolean {
			// решаем систему методом Крамера
			var _d:Number = (p12.x - p11.x) * (p21.y - p22.y) - (p21.x - p22.x) * (p12.y - p11.y);
			
			if (_d == 0) 
				return false; // Отрезки либо параллельны, либо полностью/частично совпадают
			
			var _d1:Number = (p21.x - p11.x) * (p21.y - p22.y) - (p21.x - p22.x) * (p21.y - p11.y);
			var _d2:Number = (p12.x - p11.x) * (p21.y - p11.y) - (p21.x - p11.x) * (p12.y - p11.y);
			
			var _t1:Number = _d1 / _d;
			var _t2:Number = _d2 / _d;
			
			return _t1 >= 0 && _t1 <= 1 && _t2 >= 0 && _t2 <= 1;
		}
		
		
		
		/**
		 * Проверка пересечения двух линий
		 * @param	p1
		 * @param	p2
		 * @param	p3
		 * @param	p4
		 * @return
		 */
		/*public static function intersectLines(p1:Point, p2:Point, p3:Point, p4:Point):Point {
			var x1:Number = p1.x;
			var y1:Number = p1.y;
			var x4:Number = p4.x;
			var y4:Number = p4.y;
			
			var dx1:Number = p2.x - x1;
			var dx2:Number = p3.x - x4;
			
			if (!dx1 && !dx2)
				return null;
			
			var m1:Number = (p2.y - y1) / dx1;
			var m2:Number = (p3.y - y4) / dx2;
			
			if (!dx1)
				return new Point(x1, m2 * (x1 - x4) + y4);
			
			if (!dx2)
				return new Point(x4, m1 * (x4 - x1) + y1);
			
			var xInt:Number = (-m2 * x4 + y4 + m1 * x1 - y1) / (m1 - m2);
			var yInt:Number = m1 * (xInt - x1) + y1;
			
			return new Point(xInt, yInt);
		}*/
	
	}
}