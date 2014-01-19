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
		public static function codeFormat(str:String, ...args):void {
			logFormat(MESSAGES[CODE], str, args);
		}
		
		/**
		 * @example Logger.debugFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function debugFormat(str:String, ...args):void {
			logFormat(MESSAGES[DEBUG], str, args);
		}
		
		/**
		 * @example Logger.infoFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function infoFormat(str:String, ...args):void {
			logFormat(MESSAGES[INFO], str, args);
		}
		
		/**
		 * @example Logger.warnFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function warnFormat(str:String, ...args):void {
			logFormat(MESSAGES[WARN], str, args);
		}
		
		/**
		 * @example Logger.errorFormat("Some text, {0}, {1}, {2}, 100, 200, 300);
		 * @param	str
		 * @param	...args
		 */
		public static function errorFormat(str:String, ...args):void {
			logFormat(MESSAGES[ERROR], str, args);
		}
		
		
		/**
		 * 
		 * @param	obj
		 * @param	withType
		 */
		public static function logObject(obj:Object, withType:Boolean = false):void {
			logRecursive(obj, withType, 0);
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
		
		private static function logFormat(prefix:String, str:String, ...args):void {
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
		
		
		private static function logRecursive(obj:Object, withType:Boolean, level:int):void {
			var _indent:String = '';
			for (var i:int = 0; i < level; i++)
				_indent += '  ';
			
			var _type:String = obj is Array ? 'arr' : 'obj';
			var _constructor:String = '';
			
			for (var _name:Object in obj) {
				if (withType) {
					_constructor = obj[_name].constructor;
					_constructor = ' [' + _constructor.split(' ')[1]
				}
				
				//log(_type + ':' + level, _indent + _name + ': ' + obj[_name] + _constructor);
				log(_type, _indent + _name + ': ' + obj[_name] + _constructor);
				
				if ((typeof obj[_name]) === 'object')
					logRecursive(obj[_name], withType, level + 1);
			}
		}
		
	}
}
