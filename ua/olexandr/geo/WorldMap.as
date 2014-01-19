package ua.olexandr.geo {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import net.vis4.data.DataView;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.PointSet;
	import net.vis4.geom.Polygon;
	import net.vis4.renderer.polygon.IPolygonRenderer;
	import ua.olexandr.geo.db.WorldCountries;
	import ua.olexandr.geo.projection.MapProjection;
	
	/**
	 * ...
	 * @author gka
	 */
	public class WorldMap extends Sprite {
		public static const RENDERED:String = 'Map:RENDERED';
		
		protected var _bounds:Rectangle;
		protected var _view:DataView;
		protected var _mapLayer:Sprite;
		protected var _mp:MapProjection;
		protected var _pr:IPolygonRenderer;
		protected var _countrySprites:Dictionary;
		protected var _countryInfos:Dictionary;
		
		protected var _countryPolygons:Dictionary;
		
		protected var _worldCountries:WorldCountries;
		
		protected var _viewBounds:Rectangle;
		protected var _dataBounds:Rectangle;
		protected var _lastCountryColors:Dictionary;
		protected var _defaultColor:uint;
		protected var _countryColorFunc:Function;
		protected var _countryFilterFunc:Function;
		private var _mapMask:Shape;
		
		public function WorldMap(data:String, width:Number, height:Number, mp:MapProjection, pr:IPolygonRenderer, countryColorFunc:Function = null, countryFilterFunc:Function = null) {
			_bounds = new Rectangle(0, 0, width, height);
			_mp = mp;
			_pr = pr;
			_defaultColor = pr.color;
			_mapLayer = new Sprite();
			_mapLayer.cacheAsBitmap = true;
			addChild(_mapLayer);
			_lastCountryColors = new Dictionary();
			_countryColorFunc = countryColorFunc;
			_countryFilterFunc = countryFilterFunc;
			_mapMask = new Shape();
			addChild(_mapMask);
			updateMask();
			
			_worldCountries = new WorldCountries(data);
			initMap();
			//parse(TSVParser.parse(new Data_WorldCountries().toString()));
		}
		
		private function updateMask():void {
			_mapMask.graphics.clear();
			_mapMask.graphics.beginFill(0, 1);
			_mapMask.graphics.drawRect(0, 0, _bounds.width, _bounds.height);
			_mapLayer.mask = _mapMask;
		}
		
		public function cropView(rect:Rectangle):void {
			_viewBounds = rect;
			represent(true);
		}
		
		public function resize(width:Number, height:Number):void {
			_bounds = new Rectangle(0, 0, width, height);
			trace('resized to', width, height);
			updateMask();
			represent(true);
		}
		
		protected function initMap():void {
			_countrySprites = new Dictionary(true);
			_countryInfos = new Dictionary(true);
			_countryPolygons = new Dictionary();
			var _allPoints:PointSet = new PointSet();
			
			for each (var country:Country in _worldCountries.countries) {
				if (filter(country))
					continue;
				var polygons:Array = [];
				for each (var shape:Array in country.shapes) {
					var ps:PointSet = new PointSet();
					for each (var c:MapCoordinate in shape) {
						if (Math.abs(c.lat) <= 85) {
							var p:Point = _mp.coord2point(c);
							ps.push(p);
							_allPoints.push(p);
						}
					}
					polygons.push(new Polygon(ps));
				}
				_countryPolygons[country] = polygons;
			}
			_dataBounds = _viewBounds = _allPoints.bounds;
			represent(true);
		}
		
		protected function filter(country:Country):Boolean {
			return (_countryFilterFunc is Function && _countryFilterFunc(country));
		}
		
		protected function getColor(country:Country):uint {
			if (_countryColorFunc is Function)
				return _countryColorFunc(country);
			return _defaultColor;
		
		}
		
		protected function represent(newView:Boolean = false):void {
			if (newView)
				_view = new DataView(_viewBounds, _bounds);
			
			var cntrSprite:Sprite;
			
			for each (var country:Country in _worldCountries.countries) {
				if (filter(country))
					continue;
				_pr.color = getColor(country);
				if (_lastCountryColors[country] != _pr.color || newView) {
					_lastCountryColors[country] = _pr.color;
					
					if (_countrySprites[country] is Sprite) {
						cntrSprite = _countrySprites[country] as Sprite;
						cntrSprite.graphics.clear();
					} else {
						cntrSprite = new Sprite();
						_countrySprites[country] = cntrSprite;
						_countryInfos[cntrSprite] = country;
						_mapLayer.addChild(cntrSprite);
					}
					
					for each (var polygon:IPolygon in _countryPolygons[country]) {
						if (polygon is Polygon) {
							if (_view.intersectsRect(polygon.boundingBox))
								_pr.render(polygon, cntrSprite.graphics, _view);
						} else
							trace('Polygon for ' + country.name + ' is null');
					}
					
					cntrSprite.graphics.endFill();
				}
			}
			dispatchEvent(new Event(RENDERED));
		}
		
		public function resolvePoint(p:Point):GeoLocation {
			var c:Country;
			var q:Point = _view.rp(p);
			for each (var country:Country in _worldCountries.countries) {
				for each (var polygon:IPolygon in _countryPolygons[country]) {
					if (polygon.boundingBox.containsPoint(q)) {
						if (polygon.containsPoint(q)) {
							c = country;
						}
					}
				}
			}
			if (c is Country)
				return new GeoLocation(0, 0, c);
			return null;
		}
		
		public function get view():DataView {
			return _view;
		}
		
		public function get mp():MapProjection {
			return _mp;
		}
		
		public function get viewBounds():Rectangle {
			return _viewBounds;
		}
		
		public function get dataBounds():Rectangle {
			return _dataBounds;
		}
		
		public function get countries():Array {
			return _worldCountries.countries;
		}
		
		public function get worldCountries():WorldCountries {
			return _worldCountries;
		}
		
		public function draw():void {
			represent();
		}
		
		public function countryBounds(country:Country):Rectangle {
			var b:Rectangle = new Rectangle();
			var a:Number = 0;
			var s:Number = 0;
			
			for each (var p:Polygon in _countryPolygons[country]) {
				if (!isNaN(p.boundingBox.width))
					a = Math.max(a, p.boundingBox.width * p.boundingBox.height);
			}
			s = a * .5;
			
			for each (p in _countryPolygons[country]) {
				if (!isNaN(p.boundingBox.width) && p.boundingBox.width * p.boundingBox.height > s) {
					b = b.union(p.boundingBox);
				}
			}
			b.inflate(b.width * .15, b.width * .15);
			return b;
		}
	}

}