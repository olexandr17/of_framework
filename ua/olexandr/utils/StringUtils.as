package ua.olexandr.utils {
	import ua.olexandr.constants.DirectionConst;
	import ua.olexandr.constants.LocaleConst;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class StringUtils {
		
		/**
		 * 
		 * @param	str1
		 * @param	str2
		 * @param	toCase
		 * @return
		 */
		public static function isEqual(str1:String, str2:String, toCase:Boolean = false):Boolean {
			if (!isSet(str1) || !isSet(str2))
				return false;
			
			return toCase ? str1.toUpperCase() == str2.toUpperCase() : str1 == str2;
		}
		
		/**
		 * 
		 * @param	value
		 * @return
		 */
		public static function isSet(value:String):Boolean {
			return (value != null && value.length > 0);
		}
		
		/**
		 * 
		 * @param	value
		 * @return
		 */
		public static function parse(value:*):String {
			if (value) {
				if (value is String) 						return value;
				else if (value['toString'] is Function) 	return value['toString']();
			}
			return '';
		}
		
		/**
		 * Дополняет или обрезает строку $string до нужного количества $count символов
		 * @param	$string
		 * @param	$count
		 * @param	$direction
		 * @param	$char
		 * @return
		 */
		public static function setLength(str:String, count:int, direct:String = 'left', char:String = '0'):String {
			if (!(str is String))
				return null;
			
			if (str.length < count) {
				if (direct == DirectionConst.LEFT) 			while (str.length < count) str = char + str;
				else if (direct == DirectionConst.RIGHT) 	while (str.length < count) str = str + char;
			} else if (str.length != count) {
				if (direct == DirectionConst.LEFT)	 		str = str.slice(str.length - count, str.length);
				else if (direct == DirectionConst.RIGHT) 	str = str.slice(0, count);
			}
			
			return str;
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function trimLeft(str:String):String {
			if (!(str is String))
				return null;
				
			return str.replace(/^\s+/, '');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function trimRight(str:String):String {
			if (!(str is String))
				return null;
			
			return str.replace(/\s+$/, '');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function trim(str:String):String {
			if (!(str is String))
				return null;
			
			return str.replace(/^\s+|\s+$/g, '');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function isNumeric(str:String):Boolean {
			if (str == null)
				return false;
				
			var _regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return _regx.test(str);
		}
		
		/**
		 * 
		 * @param	char
		 * @return
		 */
		public static function isWhitespace(char:String):Boolean {
			return char == '\r' || char == '\n' || char == '\f' || char == '\t' || char == ' ';
		}
		
		/**
		 * оберзает строку до заданной длины
		 * @param	str
		 * @param	len
		 * @return
		 */
        public static function truncate(str:String, len:int, ending:String = '...'):String {
			if (!(str is String))
				return null;
				
            if (str.length > len)
                str = str.substr(0, len - ending.length) + ending;
			
            return str;
        }
		
		/**
		 * Нормализует escape-переносы в строке
		 * @param	$str
		 * @return
		 */
		public static function normalize(str:String):String {
			if (!(str is String))
				return null;
			
			//var _str:String;
			//_str = str.split('\r\n').join('\n');
			//_str = str.split('\\n').join('\n');
			
			return str.replace(/[\t ]*[\r\n][\r\n\t ]*/g, '\n');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function removeDoubleLines(str:String):String {
			if (!(str is String))
				return null;
				
			return str.replace(/[\r\n][\n\r]/g, '\n');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function escapeTags(str:String):String {
			if (!isSet(str))
				return null;
			
			return str.replace('&', '&amp;')
					.replace('<', '&lt;')
					.replace('>', '&gt;')
					.replace('"', '&quot;')
					.replace("'", '&#039;');
		}
		
		/**
		 * Переворачивает строку
		 * @param	$str
		 * @return
		 */
		public static function reverse(str:String):String {
			if (!isSet(str))
				return null;
			
			return str.split('').reverse().join('');
		}
		
		/**
		 * Подсчитывает количество вхождений подстроки
		 * @param	$str
		 * @param	$char
		 * @param	$caseSensitive
		 * @return
		 */
		public static function getCount(str:String, char:String, caseSensitive:Boolean = true):uint {
			if (!isSet(str))
				return null;
			
			return str.match(new RegExp(char, caseSensitive ? 'g' : 'ig')).length;
		}
		
		/**
		 * Подсчитывает количество слов
		 * @param	$str
		 * @return
		 */
		public static function getWordCount(str:String):uint {
			if (!isSet(str))
				return null;
			
			return str.match(/\b\w+\b/g).length;
		}
		
		/**
		 * 
		 * @param	$count
		 * @param	$forms ['комментарий', 'комментария', 'комментариев']
		 * @param	$lang
		 * @return
		 */
		public static function getHumanPluralForms(count:int, forms:Array, lang:String = 'ua'):String {
			// http://translate.sourceforge.net/wiki/l10n/pluralforms
			// $forms = ['комментарий', 'комментария', 'комментариев'];
			
			var _index:int;
			
			if (forms) {
				switch (lang) {
					case LocaleConst.UA:
					case LocaleConst.RU: {
						_index = (count % 10 == 1 && count % 100 != 11 ? 0 : count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? 1 : 2);
						break;
					}
					case LocaleConst.EN: {
						_index = int(count != 1);
						break;
					}
					default: {
						break;
					}
				}
				return count + ' ' + forms[_index];
			}
			return count.toString();
		}
		
		/**
		 * Добавляет в строку разделители разрядов
		 * @param	$string
		 * @param	$separator
		 * @return
		 */
		public static function addThousandsSeparator(str:String, sep:String = ' '):String {
			if (!(str is String))
				return null;
			
			var _arr:Array = str.split('');
			var _str:String = '';
			var _len:int = _arr.length;
			
			for (var i:int = 0; i < _len; i++) {
				if (i % 3 == 0 && i > 0)
					_str = sep + _str;
					
				_str = _arr[_len - i - 1] + _str;
			}
			
			return _str;
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function toTitleCase(str:String):String {
			if (!(str is String))
				return null;
			
			var _arr:Array = str.split(' ');
			var _len:int = _arr.length;
			
			for (var i:int = 0; i < _len; i++) {
				var _str:String = _arr[i];
				_arr[i] = _str.charAt(0).toUpperCase() + _str.substr(1).toLowerCase();
			}
			return _arr.join(' ');
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
		public static function stripTags(str:String):String {
			if (!isSet(str))
				return null;
			
			return str.replace(new RegExp("<[^<]*<", "gi"), "");
		}
		
		/**
		 * 
		 * @param	str
		 * @return
		 */
        public static function decodeHTML(str:String):String {
			if (!(str is String))
				return null;
			
            var _out:String = '';
            
            //regex convert all numeric character references to regular chars
            var _arr:Array = str.match(/&#\d+;?/g);
            for (var i:Number = 0; i < _arr.length; i++) {
                var _replace:Object = String.fromCharCode((_arr[i]).replace(/\D/g,''));
                str = str.replace(/&#\d+;?/, _replace);
            }
			
            //convert all character entity references / HTML entities
            var _len:int = str.length;
            for (i = 0; i < _len; i++) {
                var _ch:String = str.charAt(i);
                if (_ch == '&') {
                    var _semicolon:Number = str.indexOf(';', i + 1);
                    if (_semicolon > 0) {
                        var _entity:String = str.substring(i + 1, _semicolon);
                        switch (_entity) {
                            case 'quot': _ch = String.fromCharCode(0x0022); break;
                            case 'amp': _ch = String.fromCharCode(0x0026); break;
                            case 'lt': _ch = String.fromCharCode(0x003c); break;
                            case 'gt': _ch = String.fromCharCode(0x003e); break;
                            case 'nbsp': _ch = String.fromCharCode(0x00a0); break;
                            case 'iexcl': _ch = String.fromCharCode(0x00a1); break;
                            case 'cent': _ch = String.fromCharCode(0x00a2); break;
                            case 'pound': _ch = String.fromCharCode(0x00a3); break;
                            case 'curren': _ch = String.fromCharCode(0x00a4); break;
                            case 'yen': _ch = String.fromCharCode(0x00a5); break;
                            case 'brvbar': _ch = String.fromCharCode(0x00a6); break;
                            case 'sect': _ch = String.fromCharCode(0x00a7); break;
                            case 'uml': _ch = String.fromCharCode(0x00a8); break;
                            case 'copy': _ch = String.fromCharCode(0x00a9); break;
                            case 'ordf': _ch = String.fromCharCode(0x00aa); break;
                            case 'laquo': _ch = String.fromCharCode(0x00ab); break;
                            case 'not': _ch = String.fromCharCode(0x00ac); break;
                            case 'shy': _ch = String.fromCharCode(0x00ad); break;
                            case 'reg': _ch = String.fromCharCode(0x00ae); break;
                            case 'macr': _ch = String.fromCharCode(0x00af); break;
                            case 'deg': _ch = String.fromCharCode(0x00b0); break;
                            case 'plusmn': _ch = String.fromCharCode(0x00b1); break;
                            case 'sup2': _ch = String.fromCharCode(0x00b2); break;
                            case 'sup3': _ch = String.fromCharCode(0x00b3); break;
                            case 'acute': _ch = String.fromCharCode(0x00b4); break;
                            case 'micro': _ch = String.fromCharCode(0x00b5); break;
                            case 'para': _ch = String.fromCharCode(0x00b6); break;
                            case 'middot': _ch = String.fromCharCode(0x00b7); break;
                            case 'cedil': _ch = String.fromCharCode(0x00b8); break;
                            case 'sup1': _ch = String.fromCharCode(0x00b9); break;
                            case 'ordm': _ch = String.fromCharCode(0x00ba); break;
                            case 'raquo': _ch = String.fromCharCode(0x00bb); break;
                            case 'frac14': _ch = String.fromCharCode(0x00bc); break;
                            case 'frac12': _ch = String.fromCharCode(0x00bd); break;
                            case 'frac34': _ch = String.fromCharCode(0x00be); break;
                            case 'iquest': _ch = String.fromCharCode(0x00bf); break;
                            case 'Agrave': _ch = String.fromCharCode(0x00c0); break;
                            case 'Aacute': _ch = String.fromCharCode(0x00c1); break;
                            case 'Acirc': _ch = String.fromCharCode(0x00c2); break;
                            case 'Atilde': _ch = String.fromCharCode(0x00c3); break;
                            case 'Auml': _ch = String.fromCharCode(0x00c4); break;
                            case 'Aring': _ch = String.fromCharCode(0x00c5); break;
                            case 'AElig': _ch = String.fromCharCode(0x00c6); break;
                            case 'Ccedil': _ch = String.fromCharCode(0x00c7); break;
                            case 'Egrave': _ch = String.fromCharCode(0x00c8); break;
                            case 'Eacute': _ch = String.fromCharCode(0x00c9); break;
                            case 'Ecirc': _ch = String.fromCharCode(0x00ca); break;
                            case 'Euml': _ch = String.fromCharCode(0x00cb); break;
                            case 'Igrave': _ch = String.fromCharCode(0x00cc); break;
                            case 'Iacute': _ch = String.fromCharCode(0x00cd); break;
                            case 'Icirc': _ch = String.fromCharCode(0x00ce ); break;
                            case 'Iuml': _ch = String.fromCharCode(0x00cf); break;
                            case 'ETH': _ch = String.fromCharCode(0x00d0); break;
                            case 'Ntilde': _ch = String.fromCharCode(0x00d1); break;
                            case 'Ograve': _ch = String.fromCharCode(0x00d2); break;
                            case 'Oacute': _ch = String.fromCharCode(0x00d3); break;
                            case 'Ocirc': _ch = String.fromCharCode(0x00d4); break;
                            case 'Otilde': _ch = String.fromCharCode(0x00d5); break;
                            case 'Ouml': _ch = String.fromCharCode(0x00d6); break;
                            case 'times': _ch = String.fromCharCode(0x00d7); break;
                            case 'Oslash': _ch = String.fromCharCode(0x00d8); break;
                            case 'Ugrave': _ch = String.fromCharCode(0x00d9); break;
                            case 'Uacute': _ch = String.fromCharCode(0x00da); break;
                            case 'Ucirc': _ch = String.fromCharCode(0x00db); break;
                            case 'Uuml': _ch = String.fromCharCode(0x00dc); break;
                            case 'Yacute': _ch = String.fromCharCode(0x00dd); break;
                            case 'THORN': _ch = String.fromCharCode(0x00de); break;
                            case 'szlig': _ch = String.fromCharCode(0x00df); break;
                            case 'agrave': _ch = String.fromCharCode(0x00e0); break;
                            case 'aacute': _ch = String.fromCharCode(0x00e1); break;
                            case 'acirc': _ch = String.fromCharCode(0x00e2); break;
                            case 'atilde': _ch = String.fromCharCode(0x00e3); break;
                            case 'auml': _ch = String.fromCharCode(0x00e4); break;
                            case 'aring': _ch = String.fromCharCode(0x00e5); break;
                            case 'aelig': _ch = String.fromCharCode(0x00e6); break;
                            case 'ccedil': _ch = String.fromCharCode(0x00e7); break;
                            case 'egrave': _ch = String.fromCharCode(0x00e8); break;
                            case 'eacute': _ch = String.fromCharCode(0x00e9); break;
                            case 'ecirc': _ch = String.fromCharCode(0x00ea); break;
                            case 'euml': _ch = String.fromCharCode(0x00eb); break;
                            case 'igrave': _ch = String.fromCharCode(0x00ec); break;
                            case 'iacute': _ch = String.fromCharCode(0x00ed); break;
                            case 'icirc': _ch = String.fromCharCode(0x00ee); break;
                            case 'iuml': _ch = String.fromCharCode(0x00ef); break;
                            case 'eth': _ch = String.fromCharCode(0x00f0); break;
                            case 'ntilde': _ch = String.fromCharCode(0x00f1); break;
                            case 'ograve': _ch = String.fromCharCode(0x00f2); break;
                            case 'oacute': _ch = String.fromCharCode(0x00f3); break;
                            case 'ocirc': _ch = String.fromCharCode(0x00f4); break;
                            case 'otilde': _ch = String.fromCharCode(0x00f5); break;
                            case 'ouml': _ch = String.fromCharCode(0x00f6); break;
                            case 'divide': _ch = String.fromCharCode(0x00f7); break;
                            case 'oslash': _ch = String.fromCharCode(0x00f8); break;
                            case 'ugrave': _ch = String.fromCharCode(0x00f9); break;
                            case 'uacute': _ch = String.fromCharCode(0x00fa); break;
                            case 'ucirc': _ch = String.fromCharCode(0x00fb); break;
                            case 'uuml': _ch = String.fromCharCode(0x00fc); break;
                            case 'yacute': _ch = String.fromCharCode(0x00fd); break;
                            case 'thorn': _ch = String.fromCharCode(0x00fe); break;
                            case 'yuml': _ch = String.fromCharCode(0x00ff); break;
                            case 'OElig': _ch = String.fromCharCode(0x0152); break;
                            case 'oelig': _ch = String.fromCharCode(0x0153); break;
                            case 'Scaron': _ch = String.fromCharCode(0x0160); break;
                            case 'scaron': _ch = String.fromCharCode(0x0161); break;
                            case 'Yuml': _ch = String.fromCharCode(0x0178); break;
                            case 'fnof': _ch = String.fromCharCode(0x0192); break;
                            case 'circ': _ch = String.fromCharCode(0x02c6); break;
                            case 'tilde': _ch = String.fromCharCode(0x02dc); break;
                            case 'Alpha': _ch = String.fromCharCode(0x0391); break;
                            case 'Beta': _ch = String.fromCharCode(0x0392); break;
                            case 'Gamma': _ch = String.fromCharCode(0x0393); break;
                            case 'Delta': _ch = String.fromCharCode(0x0394); break;
                            case 'Epsilon': _ch = String.fromCharCode(0x0395); break;
                            case 'Zeta': _ch = String.fromCharCode(0x0396); break;
                            case 'Eta': _ch = String.fromCharCode(0x0397); break;
                            case 'Theta': _ch = String.fromCharCode(0x0398); break;
                            case 'Iota': _ch = String.fromCharCode(0x0399); break;
                            case 'Kappa': _ch = String.fromCharCode(0x039a); break;
                            case 'Lambda': _ch = String.fromCharCode(0x039b); break;
                            case 'Mu': _ch = String.fromCharCode(0x039c); break;
                            case 'Nu': _ch = String.fromCharCode(0x039d); break;
                            case 'Xi': _ch = String.fromCharCode(0x039e); break;
                            case 'Omicron': _ch = String.fromCharCode(0x039f); break;
                            case 'Pi': _ch = String.fromCharCode(0x03a0); break;
                            case ' Rho ': _ch = String.fromCharCode(0x03a1); break;
                            case 'Sigma': _ch = String.fromCharCode(0x03a3); break;
                            case 'Tau': _ch = String.fromCharCode(0x03a4); break;
                            case 'Upsilon': _ch = String.fromCharCode(0x03a5); break;
                            case 'Phi': _ch = String.fromCharCode(0x03a6); break;
                            case 'Chi': _ch = String.fromCharCode(0x03a7); break;
                            case 'Psi': _ch = String.fromCharCode(0x03a8); break;
                            case 'Omega': _ch = String.fromCharCode(0x03a9); break;
                            case 'alpha': _ch = String.fromCharCode(0x03b1); break;
                            case 'beta': _ch = String.fromCharCode(0x03b2); break;
                            case 'gamma': _ch = String.fromCharCode(0x03b3); break;
                            case 'delta': _ch = String.fromCharCode(0x03b4); break;
                            case 'epsilon': _ch = String.fromCharCode(0x03b5); break;
                            case 'zeta': _ch = String.fromCharCode(0x03b6); break;
                            case 'eta': _ch = String.fromCharCode(0x03b7); break;
                            case 'theta': _ch = String.fromCharCode(0x03b8); break;
                            case 'iota': _ch = String.fromCharCode(0x03b9); break;
                            case 'kappa': _ch = String.fromCharCode(0x03ba); break;
                            case 'lambda': _ch = String.fromCharCode(0x03bb); break;
                            case 'mu': _ch = String.fromCharCode(0x03bc); break;
                            case 'nu': _ch = String.fromCharCode(0x03bd); break;
                            case 'xi': _ch = String.fromCharCode(0x03be); break;
                            case 'omicron': _ch = String.fromCharCode(0x03bf); break;
                            case 'pi': _ch = String.fromCharCode(0x03c0); break;
                            case 'rho': _ch = String.fromCharCode(0x03c1); break;
                            case 'sigmaf': _ch = String.fromCharCode(0x03c2); break;
                            case 'sigma': _ch = String.fromCharCode(0x03c3); break;
                            case 'tau': _ch = String.fromCharCode(0x03c4); break;
                            case 'upsilon': _ch = String.fromCharCode(0x03c5); break;
                            case 'phi': _ch = String.fromCharCode(0x03c6); break;
                            case 'chi': _ch = String.fromCharCode(0x03c7); break;
                            case 'psi': _ch = String.fromCharCode(0x03c8); break;
                            case 'omega': _ch = String.fromCharCode(0x03c9); break;
                            case 'thetasym': _ch = String.fromCharCode(0x03d1); break;
                            case 'upsih': _ch = String.fromCharCode(0x03d2); break;
                            case 'piv': _ch = String.fromCharCode(0x03d6); break;
                            case 'ensp': _ch = String.fromCharCode(0x2002); break;
                            case 'emsp': _ch = String.fromCharCode(0x2003); break;
                            case 'thinsp': _ch = String.fromCharCode(0x2009); break;
                            case 'zwnj': _ch = String.fromCharCode(0x200c); break;
                            case 'zwj': _ch = String.fromCharCode(0x200d); break;
                            case 'lrm': _ch = String.fromCharCode(0x200e); break;
                            case 'rlm': _ch = String.fromCharCode(0x200f); break;
                            case 'ndash': _ch = String.fromCharCode(0x2013); break;
                            case 'mdash': _ch = String.fromCharCode(0x2014); break;
                            case 'lsquo': _ch = String.fromCharCode(0x2018); break;
                            case 'rsquo': _ch = String.fromCharCode(0x2019); break;
                            case 'sbquo': _ch = String.fromCharCode(0x201a); break;
                            case 'ldquo': _ch = String.fromCharCode(0x201c); break;
                            case 'rdquo': _ch = String.fromCharCode(0x201d); break;
                            case 'bdquo': _ch = String.fromCharCode(0x201e); break;
                            case 'dagger': _ch = String.fromCharCode(0x2020); break;
                            case 'Dagger': _ch = String.fromCharCode(0x2021); break;
                            case 'bull': _ch = String.fromCharCode(0x2022); break;
                            case 'hellip': _ch = String.fromCharCode(0x2026); break;
                            case 'permil': _ch = String.fromCharCode(0x2030); break;
                            case 'prime': _ch = String.fromCharCode(0x2032); break;
                            case 'Prime': _ch = String.fromCharCode(0x2033); break;
                            case 'lsaquo': _ch = String.fromCharCode(0x2039); break;
                            case 'rsaquo': _ch = String.fromCharCode(0x203a); break;
                            case 'oline': _ch = String.fromCharCode(0x203e); break;
                            case 'frasl': _ch = String.fromCharCode(0x2044); break;
                            case 'euro': _ch = String.fromCharCode(0x20ac); break;
                            case 'image': _ch = String.fromCharCode(0x2111); break;
                            case 'weierp': _ch = String.fromCharCode(0x2118); break;
                            case 'real': _ch = String.fromCharCode(0x211c); break;
                            case 'trade': _ch = String.fromCharCode(0x2122); break;
                            case 'alefsym': _ch = String.fromCharCode(0x2135); break;
                            case 'larr': _ch = String.fromCharCode(0x2190); break;
                            case 'uarr': _ch = String.fromCharCode(0x2191); break;
                            case 'rarr': _ch = String.fromCharCode(0x2192); break;
                            case 'darr': _ch = String.fromCharCode(0x2193); break;
                            case 'harr': _ch = String.fromCharCode(0x2194); break;
                            case 'crarr': _ch = String.fromCharCode(0x21b5); break;
                            case 'lArr': _ch = String.fromCharCode(0x21d0); break;
                            case 'uArr': _ch = String.fromCharCode(0x21d1); break;
                            case 'rArr': _ch = String.fromCharCode(0x21d2); break;
                            case 'dArr': _ch = String.fromCharCode(0x21d3); break;
                            case 'hArr': _ch = String.fromCharCode(0x21d4); break;
                            case 'forall': _ch = String.fromCharCode(0x2200); break;
                            case 'part': _ch = String.fromCharCode(0x2202); break;
                            case 'exist': _ch = String.fromCharCode(0x2203); break;
                            case 'empty': _ch = String.fromCharCode(0x2205); break;
                            case 'nabla': _ch = String.fromCharCode(0x2207); break;
                            case 'isin': _ch = String.fromCharCode(0x2208); break;
                            case 'notin': _ch = String.fromCharCode(0x2209); break;
                            case 'ni': _ch = String.fromCharCode(0x220b); break;
                            case 'prod': _ch = String.fromCharCode(0x220f); break;
                            case 'sum': _ch = String.fromCharCode(0x2211); break;
                            case 'minus': _ch = String.fromCharCode(0x2212); break;
                            case 'lowast': _ch = String.fromCharCode(0x2217); break;
                            case 'radic': _ch = String.fromCharCode(0x221a); break;
                            case 'prop': _ch = String.fromCharCode(0x221d); break;
                            case 'infin': _ch = String.fromCharCode(0x221e); break;
                            case 'ang': _ch = String.fromCharCode(0x2220); break;
                            case 'and': _ch = String.fromCharCode(0x2227); break;
                            case 'or': _ch = String.fromCharCode(0x2228); break;
                            case 'cap': _ch = String.fromCharCode(0x2229); break;
                            case 'cup': _ch = String.fromCharCode(0x222a); break;
                            case 'int': _ch = String.fromCharCode(0x222b); break;
                            case 'there4': _ch = String.fromCharCode(0x2234); break;
                            case 'sim': _ch = String.fromCharCode(0x223c); break;
                            case 'cong': _ch = String.fromCharCode(0x2245); break;
                            case 'asymp': _ch = String.fromCharCode(0x2248); break;
                            case 'ne': _ch = String.fromCharCode(0x2260); break;
                            case 'equiv': _ch = String.fromCharCode(0x2261); break;
                            case 'le': _ch = String.fromCharCode(0x2264); break;
                            case 'ge': _ch = String.fromCharCode(0x2265); break;
                            case 'sub': _ch = String.fromCharCode(0x2282); break;
                            case 'sup': _ch = String.fromCharCode(0x2283); break;
                            case 'nsub': _ch = String.fromCharCode(0x2284); break;
                            case 'sube': _ch = String.fromCharCode(0x2286); break;
                            case 'supe': _ch = String.fromCharCode(0x2287); break;
                            case 'oplus': _ch = String.fromCharCode(0x2295); break;
                            case 'otimes': _ch = String.fromCharCode(0x2297); break;
                            case 'perp': _ch = String.fromCharCode(0x22a5); break;
                            case 'sdot': _ch = String.fromCharCode(0x22c5); break;
                            case 'lceil': _ch = String.fromCharCode(0x2308); break;
                            case 'rceil': _ch = String.fromCharCode(0x2309); break;
                            case 'lfloor': _ch = String.fromCharCode(0x230a); break;
                            case 'rfloor': _ch = String.fromCharCode(0x230b); break;
                            case 'lang': _ch = String.fromCharCode(0x2329); break;
                            case 'rang': _ch = String.fromCharCode(0x232a); break;
                            case 'loz': _ch = String.fromCharCode(0x25ca); break;
                            case 'spades': _ch = String.fromCharCode(0x2660); break;
                            case 'clubs': _ch = String.fromCharCode(0x2663); break;
                            case 'hearts': _ch = String.fromCharCode(0x2665); break;
                            case 'diams': _ch = String.fromCharCode(0x2666); break;
                            default: _ch = ''; break;
                        }
                        i = _semicolon;
                    }
                }
                _out += _ch;
            }
            return _out;
        }
		
	}
}