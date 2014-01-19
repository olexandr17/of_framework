package ua.olexandr.geo {
	import ua.olexandr.utils.MathUtils;
	
	public class MapCoordinate {
		public var latitude:Number;
		public var longitude:Number;
		
		public function MapCoordinate(lat:Number, lng:Number) {
			latitude = lat;
			longitude = lng;
		}
		
		public function isEquals(m:MapCoordinate, count:uint = 2):Boolean {
			return MathUtils.round(m.latitude, count) == MathUtils.round(latitude, count) && MathUtils.round(m.longitude, count) == MathUtils.round(longitude, count);
		}
		
		public function toString():String {
			return "[MapCoordinate latitude=" + latitude + " longitude=" + longitude + "]";
		}
		
	}

}