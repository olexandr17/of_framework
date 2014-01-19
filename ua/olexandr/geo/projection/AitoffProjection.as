﻿package ua.olexandr.geo.projection {
	import flash.geom.Point;
	import ua.olexandr.geo.MapCoordinate;
	
	/**
	 * ...
	 * @author gka
	 */
	public class AitoffProjection extends MapProjection {
		
		public function AitoffProjection(scale:Number = 10000) {
			super(scale);
		}
		
		public override function coord2point(c:MapCoordinate):Point {
			var lat:Number = c.lat * Math.PI / -180;
			var lng:Number = c.lng * Math.PI / 180;
			var alpha:Number = Math.acos(Math.cos(lat) * Math.cos(lng / 2));
			if (lat == 0 && lng == 0)
				return new Point(0, 0);
			
			return new Point(_scale * ((2 * Math.cos(lat) * Math.sin(lng / 2)) / sinc(alpha)), _scale * (Math.sin(lat) / sinc(alpha)));
		}
	
	}

}