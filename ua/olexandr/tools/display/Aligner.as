package ua.olexandr.tools.display {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ua.olexandr.constants.AlignConst;
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public class Aligner {
		
		public static const TL:String = AlignConst.TL;
		public static const TC:String = AlignConst.TC;
		public static const TR:String = AlignConst.TR;
		public static const CL:String = AlignConst.CL;
		public static const CC:String = AlignConst.CC;
		public static const CR:String = AlignConst.CR;
		public static const BL:String = AlignConst.BL;
		public static const BC:String = AlignConst.BC;
		public static const BR:String = AlignConst.BR;
		
		
		private static var _calc:Boolean = false;
		
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToTL(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, TL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToTC(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, TC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToTR(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, TR);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToCL(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, CL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToCC(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, CC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToCR(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, CR);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToBL(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, BL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToBC(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, BC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function alignToBR(target:DisplayObject, rect:Rectangle = null):Point {
			return align(target, rect, BR);
		}
		
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToTL(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, TL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToTC(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, TC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToTR(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, TR);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToCL(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, CL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToCC(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, CC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToCR(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, CR);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToBL(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, BL);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToBC(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, BC);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @return
		 */
		public static function calcToBR(target:DisplayObject, rect:Rectangle = null):Point {
			_calc = true;
			return align(target, rect, BR);
		}
		
		
		/**
		 * 
		 * @param	target
		 * @param	rect
		 * @param	location
		 * @return
		 */
		public static function align(target:DisplayObject, rect:Rectangle = null, location:String = 'CC'):Point {
			rect ||= new Rectangle(0, 0, 0, 0);
			location = location.toUpperCase();
			
			var _p:Point = new Point();
			
			switch (location) {
				case TL: {
					_p.x = Math.ceil(rect.x);
					_p.y = Math.ceil(rect.y);
					break;
				}
				case TC: {
					_p.x = Math.round(rect.x + (rect.width - target.width) * .5);
					_p.y = Math.ceil(rect.y);
					break;
				}
				case TR: {
					_p.x = Math.floor(rect.x + rect.width - target.width);
					_p.y = Math.ceil(rect.y);
					break;
				}
				case CL: {
					_p.x = Math.ceil(rect.x);
					_p.y = Math.round(rect.y + (rect.height - target.height) * .5);
					break;
				}
				case CR: {
					_p.x = Math.floor(rect.x + rect.width - target.width);
					_p.y = Math.round(rect.y + (rect.height - target.height) * .5);
					break;
				}
				case BL: {
					_p.x = Math.ceil(rect.x);
					_p.y = Math.floor(rect.y + rect.height - target.height);
					break;
				}
				case BC: {
					_p.x = Math.round(rect.x + (rect.width - target.width) * .5);
					_p.y = Math.floor(rect.y + rect.height - target.height);
					break;
				}
				case BR: {
					_p.x = Math.floor(rect.x + rect.width - target.width);
					_p.y = Math.floor(rect.y + rect.height - target.height);
					break;
				}
				default: {
					_p.x = Math.round(rect.x + (rect.width - target.width) * .5);
					_p.y = Math.round(rect.y + (rect.height - target.height) * .5);
					break;
				}
			}
			
			if (_calc) {
				_calc = false;
			} else {
				target.x = _p.x;
				target.y = _p.y;
			}
			
			return _p;
		}
		
		
		/**
		 * 
		 * @param	target
		 * @param	isParent
		 * @return
		 */
		public static function getRect(target:DisplayObject, isParent:Boolean = true):Rectangle {
			var _rect:Rectangle = new Rectangle();
			
			if (!isParent) {
				_rect.x = target.x;
				_rect.y = target.y;
			}
			
			if (target is Stage) {
				_rect.width = (target as Stage).stageWidth;
				_rect.height = (target as Stage).stageHeight;
			} else {
				_rect.width = target.width;
				_rect.height = target.height;
			}
			
			return _rect;
		}
		
	}
}

/*
		public static function fitIntoRect(displayObject : DisplayObject, rectangle : Rectangle, fillRect : Boolean = true, align : String = "C", applyTransform : Boolean = true) : Matrix
		{
			var matrix : Matrix = new Matrix();
			
			var wD : Number = displayObject.width / displayObject.scaleX;
			var hD : Number = displayObject.height / displayObject.scaleY;
			
			var wR : Number = rectangle.width;
			var hR : Number = rectangle.height;
			
			var sX : Number = wR / wD;
			var sY : Number = hR / hD;
			
			var rD : Number = wD / hD;
			var rR : Number = wR / hR;
			
			var sH : Number = fillRect ? sY : sX;
			var sV : Number = fillRect ? sX : sY;
			
			var s : Number = rD >= rR ? sH : sV;
			var w : Number = wD * s;
			var h : Number = hD * s;
			
			var tX : Number = 0.0;
			var tY : Number = 0.0;
			
			switch(align)
			{
				case Alignment.LEFT :
				case Alignment.TOP_LEFT :
				case Alignment.BOTTOM_LEFT :
					tX = 0.0;
					break;
					
				case Alignment.RIGHT :
				case Alignment.TOP_RIGHT :
				case Alignment.BOTTOM_RIGHT :
					tX = w - wR;
					break;
					
				default : 					
					tX = 0.5 * (w - wR);
			}
			
			switch(align)
			{
				case Alignment.TOP :
				case Alignment.TOP_LEFT :
				case Alignment.TOP_RIGHT :
					tY = 0.0;
					break;
					
				case Alignment.BOTTOM :
				case Alignment.BOTTOM_LEFT :
				case Alignment.BOTTOM_RIGHT :
					tY = h - hR;
					break;
					
				default : 					
					tY = 0.5 * (h - hR);
			}
			
			matrix.scale(s, s);
			matrix.translate(rectangle.left - tX, rectangle.top - tY);
			
			if(applyTransform)
				displayObject.transform.matrix = matrix;
			
			return matrix;
		}
*/