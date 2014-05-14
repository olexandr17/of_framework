package ua.olexandr.social.vkontakte {
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="complete", type="flash.events.Event")]
	public class VKRequest extends EventDispatcher{
		
		public var error:String;
		public var data:XML;
		
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		/**
		 * 
		 * @param	request
		 */
		public function VKRequest(request:URLRequest) {
			_request = request;
		}
		
		/**
		 * Выполнить запрос
		 */
		public function load():void {
			if (_request.url) {
				_loader = new URLLoader();
				_loader.addEventListener(Event.COMPLETE, completeHandler);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
				_loader.load(_request);
			}
		}
		
		
		private function errorHandler(e:Event):void {
			error = e['text'];
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
		
		private function completeHandler(e:Event):void {
			data = XML(e.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}