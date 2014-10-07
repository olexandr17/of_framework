package ua.olexandr.utils {
	import flash.filters.ColorMatrixFilter;
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public class FilterUtils {
		
		public static const PROTANOPIA:String = "Protanopia";
		public static const PROTANOMALY:String = "Protanomaly"
		public static const DEUTERANOPIA:String = "Deuteranopia"
		public static const DEUTERANOMALY:String = "Deuteranomaly"
		public static const TRITANOPIA:String = "Tritanopia"
		public static const TRITANOMALY:String = "Tritanomaly"
		public static const ACHROMATOPSIA:String = "Achromatopsia"
		public static const ACHROMATOMALY:String = "Achromatomaly"
		
		private static const LUMA_R:Number = 0.212671;
		private static const LUMA_G:Number = 0.71516;
		private static const LUMA_B:Number = 0.072169;
		
		/**
		 * Get identity filter
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getIdentityFilter():ColorMatrixFilter {
			return new ColorMatrixFilter([ 	1, 0, 0, 0, 0, 
											0, 1, 0, 0, 0, 
											0, 0, 1, 0, 0, 
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get grayscale filter
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getGrayscaleFilter():ColorMatrixFilter {
			return new ColorMatrixFilter([ 	0.3086, 0.6094, 0.082, 0, 0,
											0.3086, 0.6094, 0.082, 0, 0,
											0.3086, 0.6094, 0.082, 0, 0,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get negative filter
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getNegativeFilter():ColorMatrixFilter {
			return new ColorMatrixFilter([ 	-1, 0, 0, 0, 255,
											0, -1, 0, 0, 255,
											0, 0, -1, 0, 255,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get X-Ray filter
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getXRayFilter():ColorMatrixFilter {
			return new ColorMatrixFilter([ 	0, 0, 0, 0, 255, 
											0, 0, 0, 0, 255, 
											0, 0, 0, 0, 255, 
											-1, -1, -1, 0, 255]);
		}
		
		/**
		 * Get hue filter
		 * @param	degrees				from 0 to 360
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getHueFilter(degrees:Number):ColorMatrixFilter {
            var _cos:Number = Math.cos(degrees * Math.PI / 180);
            var _sin:Number = Math.sin(degrees * Math.PI / 180);
			
			return new ColorMatrixFilter([
				((LUMA_R + (_cos * (1 - LUMA_R))) + (_sin * -LUMA_R)), ((LUMA_G + (_cos * -LUMA_G)) + (_sin * -LUMA_G)), ((LUMA_B + (_cos * -LUMA_B)) + (_sin * (1 - LUMA_B))), 0, 0,
				((LUMA_R + (_cos * -LUMA_R)) + (_sin * 0.143)), ((LUMA_G + (_cos * (1 - LUMA_G))) + (_sin * 0.14)), ((LUMA_B + (_cos * -LUMA_B)) + (_sin * -0.283)), 0, 0,
				((LUMA_R + (_cos * -LUMA_R)) + (_sin * -((1 - LUMA_R)))), ((LUMA_G + (_cos * -(LUMA_G))) + (_sin * LUMA_G)), ((LUMA_B + (_cos * (1 - LUMA_B))) + (_sin * LUMA_B)), 0, 0,
				0, 0, 0, 1, 0]);
        }

		/**
		 * Gets brightness filter
		 * @param 	value				from -100 to 100
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getBrightnessFilter(value:Number):ColorMatrixFilter {
			value = value * (255 / 250);
    		return new ColorMatrixFilter([	1, 0, 0, 0, value,
											0, 1, 0, 0, value,
											0, 0, 1, 0, value,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get contrast filter
		 * @param 	value				from -100 to 100
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getContrastFilter(value:Number):ColorMatrixFilter {
			var _s:Number = value / 100 + 1;
    		var _o:Number = 128 * (1 - _s);
			
			return new ColorMatrixFilter([	_s, 0, 0, 0, _o,
											0, _s, 0, 0, _o,
											0, 0, _s, 0, _o,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get saturation filter
		 * @param 	value				from -100 to 100
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getSaturationFilter(value:Number):ColorMatrixFilter {
			var _v:Number = (value / 100) + 1;
			var _i:Number = (1 - _v);
   		 	var _r:Number = (_i * LUMA_R);
    		var _g:Number = (_i * LUMA_G);
    		var _b:Number = (_i * LUMA_B);
			
 			return new ColorMatrixFilter([	_r + _v, _g, _b, 0, 0,
											_r, _g + _v, _b, 0, 0,
											_r, _g, _b + _v, 0, 0,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get sepia filter
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getSepiaFilter():ColorMatrixFilter {
			return new ColorMatrixFilter([	0.3930000066757202, 0.7689999938011169, 0.1889999955892563, 0, 0,
											0.3490000069141388, 0.6859999895095825, 0.1679999977350235, 0, 0,
											0.2720000147819519, 0.5339999794960022, 0.1309999972581863, 0, 0,
											0, 0, 0, 1, 0,
											0, 0, 0, 0, 1]);

		}
	
		/**
		 * Get multiplies filter
		 * @param	r					from 0 to 1
		 * @param	g					from 0 to 1
		 * @param	b					from 0 to 1
		 * @param	a					from 0 to 1
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getChannelFilter(r:Number, g:Number, b:Number, a:Number):ColorMatrixFilter {
			return new ColorMatrixFilter([ 	r, 0, 0, 0, 0, 
											0, g, 0, 0, 0, 
											0, 0, b, 0, 0, 
											0, 0, 0, a, 0]);
		}
		
		/**
		 * Get rgb filter
		 * @param	amount				from 0 to 1 
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getColorFilter(rgb:int, amount:Number = 1):ColorMatrixFilter {
            var _amount:Number = (1 - amount);
			var _amountR:Number = _amount * (((rgb >> 16) & 0xFF) / 0xFF);
            var _amountG:Number = _amount * (((rgb >> 8) & 0xFF) / 0xFF);
            var _amountB:Number = _amount * ((rgb & 0xFF) / 0xFF);
           
            return new ColorMatrixFilter([
				(_amount + (_amountR * LUMA_R)), (_amountR * LUMA_G), (_amountR * LUMA_B), 0, 0,
				(_amountG * LUMA_R), (_amount + (_amountG * LUMA_G)), (_amountG * LUMA_B), 0, 0,
				(_amountB * LUMA_R), (_amountB * LUMA_G), (_amount + (_amountB * LUMA_B)), 0, 0,
				0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get random filter
		 * @param	amount				from 0 to 1 
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getRandomizeFilter(amount:Number = 1):ColorMatrixFilter {
			var inv_amount:Number = (1 - amount);
            var r1:Number = (inv_amount + (amount * (Math.random() - Math.random())));
            var g1:Number = (amount * (Math.random() - Math.random()));
            var b1:Number = (amount * (Math.random() - Math.random()));
            var o1:Number = ((amount * 0xFF) * (Math.random() - Math.random()));
            var r2:Number = (amount * (Math.random() - Math.random()));
            var g2:Number = (inv_amount + (amount * (Math.random() - Math.random())));
            var b2:Number = (amount * (Math.random() - Math.random()));
            var o2:Number = ((amount * 0xFF) * (Math.random() - Math.random()));
            var r3:Number = (amount * (Math.random() - Math.random()));
            var g3:Number = (amount * (Math.random() - Math.random()));
            var b3:Number = (inv_amount + (amount * (Math.random() - Math.random())));
            var o3:Number = ((amount * 0xFF) * (Math.random() - Math.random()));
           
            return new ColorMatrixFilter(	[r1, g1, b1, 0, o1,
											r2, g2, b2, 0, o2,
											r3, g3, b3, 0, o3,
											0, 0, 0, 1, 0]);
		}
		
		/**
		 * Get color deficiency filter
		 * @param	type
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getColorDeficiencyFilter(type:String):ColorMatrixFilter {
			var _matrix:Array;
			
			switch (type) {
				case PROTANOPIA: {
					_matrix = [	0.567, 0.433, 0, 0, 0, 
								0.558, 0.442, 0, 0, 0, 
								0, 0.242, 0.758, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case PROTANOMALY: {
					_matrix = [	0.817, 0.183, 0, 0, 0, 
								0.333, 0.667, 0, 0, 0, 
								0, 0.125, 0.875, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case DEUTERANOPIA: {
					_matrix = [	0.625, 0.375, 0, 0, 0, 
								0.7, 0.3, 0, 0, 0, 
								0, 0.3, 0.7, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case DEUTERANOMALY: {
					_matrix = [	0.8, 0.2, 0, 0, 0, 
								0.258, 0.742, 0, 0, 0, 
								0, 0.142, 0.858, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case TRITANOPIA: {
					_matrix = [	0.95, 0.05, 0, 0, 0, 
								0, 0.433, 0.567, 0, 0, 
								0, 0.475, 0.525, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case TRITANOMALY: {
					_matrix = [	0.967, 0.033, 0, 0, 0, 
								0, 0.733, 0.267, 0, 0, 
								0, 0.183, 0.817, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case ACHROMATOPSIA: {
					_matrix = [	0.299, 0.587, 0.114, 0, 0, 
								0.299, 0.587, 0.114, 0, 0, 
								0.299, 0.587, 0.114, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
                case ACHROMATOMALY: {
					_matrix = [	0.618, 0.320, 0.062, 0, 0, 
								0.163, 0.775, 0.062, 0, 0, 
								0.163, 0.320, 0.516, 0, 0, 
								0, 0, 0, 1, 0];
					break;
				}
			}
			
			return _matrix ? new ColorMatrixFilter(_matrix) : getIdentityFilter();
		}
		
		/**
		 * Concat filters
		 * @param	...filters
		 * @return	ColorMatrixFilter
		 */
		[Inline]
		public static function getConcatFilter(...filters):ColorMatrixFilter {
			throw new Error("This method didn't has implementation yet");
			
			/*var _target:Array;
			
			var _len:int = filters.length;
			for (var l:int = 0; l < _len; l++) {
				var _filter:ColorMatrixFilter = filters[i] as ColorMatrixFilter;
				if (_filter) {
					if (_target) {
						var col:Array = [];
						
						for (var i:int = 0; i < 4; i++) {
							for (var j:int = 0; j < 5; j++)
								col[j] = _target[j + (i * 5)];
							
							for (j = 0; j < 5; j++) {
								var val:Number = 0;
								for (var k:Number = 0; k < 4; k++)
									val += _filter.matrix[j + (k * 5)] * col[k];
								
								_target[j + (i * 5)] = val;
							}
						}
					} else {
						_target = _filter.matrix.concat();
					}
				}
			}
			
			return _target ? new ColorMatrixFilter(_target) : getIdentityFilter();*/
		}
		
	}

}
