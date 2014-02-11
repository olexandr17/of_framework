package ua.olexandr._ {
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	public class LayoutUtils {
		/**
		 * Creates a grid and returns a vector of points with x and y values based on passed parameters.
		 * The $leftToRight addition was contributed by Skye Giordano.
		 *
		 * @param $columns An integer representing the number of columns to be created in the grid
		 * @param $rows An integer representing the number of rows to be created in the grid
		 * @param $xSpacing An integer representing the spacing between columns
		 * @param $ySpacing An integer representing the spacing between rows
		 * @param $xPadding An integer representing the padding between each column
		 * @param $yPadding An integer representing the padding between each row
		 * @param $leftToRight An optional boolean that creates the grid from left-to-right or top-to-bottom (default: true)
		 *
		 * @return Vector.<Point>
		 */
		public static function createGrid($columns:int, $rows:int, $xSpacing:int, $ySpacing:int, $xPadding:int, $yPadding:int, $leftToRight:Boolean = true):Vector.<Point> {
			var points:Vector.<Point> = new Vector.<Point>();
			var pt:Point;
			var row:Number;
			var col:Number;
			var num:int = ($columns * $rows);
			
			for (var i:int = 0; i < num; i++) {
				pt = new Point();
				
				if ($leftToRight) {
					row = (i % $columns);
					col = Math.floor(i / $columns);
					
					pt.x = (row * ($xSpacing + $xPadding));
					pt.y = (col * ($ySpacing + $yPadding));
				} else {
					row = (i % $rows);
					col = Math.floor(i / $rows);
					
					pt.x = (col * ($xSpacing + $xPadding));
					pt.y = (row * ($ySpacing + $yPadding));
				}
				
				points.push(pt);
			}
			
			return points;
		}
	
	}
}