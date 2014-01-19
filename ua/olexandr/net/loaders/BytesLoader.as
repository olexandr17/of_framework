package ua.olexandr.net.loaders {
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import ua.olexandr.events.LoaderEvent;
	
	/**
	 * ...
	 * @author @author Olexandr Fedorow,
	 * @copy Copyright (c) 2012
	 * @link http://www.olexandr.org
	 * @link www.olexandr@gmail.com
	 * @version 0.1
	 */
	[Event(name = "start", type = "ua.olexandr.events.LoaderEvent")]
	[Event(name = "progress", type = "ua.olexandr.events.LoaderEvent")]
	[Event(name = "fail", type = "ua.olexandr.events.LoaderEvent")]
	[Event(name = "success", type = "ua.olexandr.events.LoaderEvent")]
	[Event(name = "finish", type = "ua.olexandr.events.LoaderEvent")]
	public class BytesLoader extends EventDispatcher implements ILoader {
		
		/**
		 * 
		 * @return
		 */
		public function getBytes():ByteArray {
			if (!_content)
				return null;
			
			return _content;
		}
		
		private var _request:URLRequest;
		private var _loader:URLStream;
		
		private var _bytesTotal:uint;
		private var _bytesLoaded:uint;
		private var _percentage:Number;
		private var _running:Boolean;
		
		private var _content:ByteArray;
		private var _error:String;
		
		/**
		 * 
		 * @param	url
		 */
		public function BytesLoader(url:*) {
			if (url is URLRequest)	_request = url;
			else					_request = new URLRequest(url is String ? url : String(url));
			
			_loader = new URLStream();
			_loader.addEventListener(Event.COMPLETE, completeHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			_loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		/**
		 * 
		 */
		public function load():void {
			_running = true;
			
			_loader.load(_request);
			
			dispatchEvent(new LoaderEvent(LoaderEvent.START));
		}
		
		/**
		 * 
		 */
		public function close():void {
			try {
				_loader.close();
			} catch (err:Error) { }
		}
		
		/**
		 * 
		 */
		public function destroy():void {
			close();
			
			_loader.removeEventListener(Event.COMPLETE, completeHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			_loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader = null;
			
			_content = null;
			_error = null;
		}
		
		/**
		 * 
		 * @return
		 */
		public function isRunning():Boolean { return _running; }
		
		/**
		 * 
		 */
		public function get request():URLRequest { return _request; }
		
		/**
		 * 
		 */
		public function get bytesLoaded():uint { return _bytesLoaded; }
		/**
		 * 
		 */
		public function get bytesTotal():uint { return _bytesTotal; }
		/**
		 * 
		 */
		public function get percentage():Number { return _percentage; }
		
		/**
		 * 
		 */
		public function get content():* { return _content; }
		/**
		 * 
		 */
		public function get error():String { return _error; }
		
		
		private function progressHandler(e:ProgressEvent):void {
			_bytesTotal = e.bytesTotal;
			_bytesLoaded = e.bytesLoaded;
			_percentage = _bytesLoaded / _bytesTotal;
			
			var _event:LoaderEvent = new LoaderEvent(LoaderEvent.PROGRESS);
			_event.bytesTotalCurrent = _bytesTotal;
			_event.bytesLoadedCurrent = _bytesLoaded;
			_event.percentageTotal = _percentage;
			_event.percentageCurrent = _percentage;
			dispatchEvent(_event);
		}
		
		private function errorHandler(e:ErrorEvent):void {
			_error = e.text;
			_running = false;
			
			var _event:LoaderEvent = new LoaderEvent(LoaderEvent.FAIL);
			_event.error = _error;
			dispatchEvent(_event);
			
			dispatchFinish();
		}
		
		private function completeHandler(e:Event):void {
			_content = new ByteArray();
			_loader.readBytes(_content);
			
			_running = false;
			
			var _event:LoaderEvent = new LoaderEvent(LoaderEvent.SUCCESS);
			_event.content = _content;
			dispatchEvent(_event);
			
			dispatchFinish();
		}
		
		private function dispatchFinish():void {
			var _event:LoaderEvent = new LoaderEvent(LoaderEvent.FINISH);
			_event.error = _error;
			_event.content = _content;
			dispatchEvent(_event);
		}
		
	}

}