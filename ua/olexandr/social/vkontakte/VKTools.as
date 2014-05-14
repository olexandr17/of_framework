package ua.olexandr.social.vkontakte {
	import com.adobe.crypto.MD5;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class VKTools{
		
		/**
		 * 
		 * @param	vars
		 * @return
		 */
		public static function createSignature(vars:Object):String {
			var _arr:Array = [];
			for (var s:String in vars) _arr.push(s);
			_arr.sort(Array.CASEINSENSITIVE);
			
			var _str:String = VKVars.get(VKVars.VAR_VIEWER_ID);
			for (var i:int = 0; i < _arr.length; i++) {
				_str += (_arr[i] + '=' + vars[_arr[i]]);
			}
			_str += VKVars.secret;
			
			return MD5.hash(_str);
		}
		
	}

}