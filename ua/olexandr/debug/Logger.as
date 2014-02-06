package ua.olexandr.debug {
	import ua.olexandr.debug.loggers.ILoggable;
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.5
	 */
	public class Logger {
		
		public static const CODE:int = 0;
		public static const DEBUG:int = 1;
		public static const INFO:int = 2;
		public static const WARN:int = 3;
		public static const ERROR:int = 4;
		
		private static const PREFIXES:Array = ["0:", "1:", "1:", "2:", "3:"];
		private static const MESSAGES:Array = ["COD", "DBG", "INF", "WRN", "ERR"];
		
		/**
		 * 
		 */
		public static var coloring:Boolean = true;
		/**
		 * 
		 */
		public static var level:int = CODE;
		
		private static var _loggers:Array = [];
		
		
		/**
		 * 
		 * @param	logger
		 */
		public static function addLogger(logger:ILoggable):void {
			if (logger && logger is ILoggable && _loggers.indexOf(logger) == -1)
				_loggers.push(logger);
		}
		
		
		/**
		 * 
		 * @param	...args
		 */
		public static function code(...args):void {
			log(MESSAGES[CODE], args);
		}
		
		/**
		 * 
		 * @param	...args
		 */
		public static function debug(...args):void {
			log(MESSAGES[DEBUG], args);
		}
		
		/**
		 * 
		 * @param	...args
		 */
		public static function info(...args):void {
			log(MESSAGES[INFO], args);
		}
		
		/**
		 * 
		 * @param	...args
		 */
		public static function warn(...args):void {
			log(MESSAGES[WARN], args);
		}
		
		/**
		 * 
		 * @param	...args
		 */
		public static function error(...args):void {
			log(MESSAGES[ERROR], args);
		}
		
		
		/**
		 * @example Logger.codeFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function codeF(str:String, ...args):void {
			logF(MESSAGES[CODE], str, args);
		}
		
		/**
		 * @example Logger.debugFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function debugF(str:String, ...args):void {
			logF(MESSAGES[DEBUG], str, args);
		}
		
		/**
		 * @example Logger.infoFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function infoF(str:String, ...args):void {
			logF(MESSAGES[INFO], str, args);
		}
		
		/**
		 * @example Logger.warnFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function warnF(str:String, ...args):void {
			logF(MESSAGES[WARN], str, args);
		}
		
		/**
		 * @example Logger.errorFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function errorF(str:String, ...args):void {
			logF(MESSAGES[ERROR], str, args);
		}
		
		/**
		 * 
		 * @param	obj
		 */
		public static function codeObj(obj:Object, levelMax:int = int.MAX_VALUE):void {
			logObjRecursive(MESSAGES[CODE], obj, 0, levelMax);
		}
		
		/**
		 * 
		 * @param	obj
		 */
		public static function debugObj(obj:Object, levelMax:int = int.MAX_VALUE):void {
			logObjRecursive(MESSAGES[DEBUG], obj, 0, levelMax);
		}
		
		/**
		 * 
		 * @param	obj
		 */
		public static function infoObj(obj:Object, levelMax:int = int.MAX_VALUE):void {
			logObjRecursive(MESSAGES[INFO], obj, 0, levelMax);
		}
		
		/**
		 * 
		 * @param	obj
		 */
		public static function warnObj(obj:Object, levelMax:int = int.MAX_VALUE):void {
			logObjRecursive(MESSAGES[WARN], obj, 0, levelMax);
		}
		
		/**
		 * 
		 * @param	obj
		 */
		public static function errorObj(obj:Object, levelMax:int = int.MAX_VALUE):void {
			logObjRecursive(MESSAGES[ERROR], obj, 0, levelMax);
		}
		
		
		private static function log(prefix:String, ...args):void {
			if (MESSAGES.indexOf(prefix) >= level) {
				var _color:String = coloring ? PREFIXES[MESSAGES.indexOf(prefix)] as String : "";
				var _message:String = args.join(', ');
				
				trace(_color + (prefix ? '[' + prefix + '] ' : '') + _message);
				
				var _len:uint = _loggers.length;
				for (var i:int = 0; i < _len; i++) {
					var _logger:ILoggable = _loggers[i] as ILoggable;
					switch(prefix) {
						case WARN: {
							_logger.warn(_message);
							break;
						}
						case ERROR: {
							_logger.error(_message);
							break;
						}
						case DEBUG: {
							_logger.debug(_message);
							break;
						}
						case CODE: {
							_logger.code(_message);
							break;
						}
						default: {
							_logger.info(_message);
						}
					}
				}
			}
		}
		
		private static function logF(prefix:String, str:String, ...args):void {
			var _len:uint = args.length;
			var _arr:Array;
			
			if (_len == 1 && args[0] is Array) {
				_arr = args[0] as Array;
				_len = _arr.length;
			} else {
				_arr = args;
			}
			
			for (var i:int = 0; i < _len; i++)
				str = str.replace(new RegExp("\\{" + i + "\\}", "g"), _arr[i]);
			
			log(prefix, str);
		}
		
		private static function logObjRecursive(prefix:String, obj:Object, level:int, levelMax:int):void {
			if (level < levelMax) {
				var _indent:String = '';
				for (var i:int = 0; i < level; i++)
					_indent += '    ';
				
				for (var _name:Object in obj) {
					
					var _count:int = 0;
					for (var _:Object in obj[_name])
						_count++;
					
					if (_count && level != levelMax - 1) {
						var _type:String = String(obj[_name].constructor).match(/[A-Z0-9_]+/gi)[1];
						var _brackets:Array;
						switch (_type) {
							case "Object": 	{ _brackets = ["{", "}"]; break; }
							case "Array": 	{ _brackets = ["[", "]"]; break; }
							default: 		{ _brackets = ["<", ">"]; }
						}
						
						log(prefix, _indent + _name + ": " + _brackets[0]);
						logObjRecursive(prefix, obj[_name], level + 1, levelMax);
						log(prefix, _indent + _brackets[1]);
					} else {
						log(prefix, _indent + _name + ': ' + obj[_name]);
					}
				}
			}
		}
		
	}
}
