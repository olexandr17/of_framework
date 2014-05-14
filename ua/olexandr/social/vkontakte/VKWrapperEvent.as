package ua.olexandr.social.vkontakte {
	import flash.events.Event;
	/**
	 * ...
	 * @author Fedorow Olexandr
	 */
	public class VKWrapperEvent extends Event {
		
		// Пользователь добавляет приложение к себе на страницу.
		public static const APPLICATION_ADDED:String 	= 'onApplicationAdded';
		
		// Пользователь изменяет настройки приложений. 
		public static const PERMISSIONS_CHANGED:String 	= 'onSettingsChanged';
		
		// Пользователь положил или снял голоса с баланса приложения.
		public static const BALANCE_CHANGED:String 		= 'onBalanceChanged';
		
		// Пользователь подтвердил сохранение фотографии в окне, вызванном с помощью функции showProfilePhotoBox.
		public static const PROFILE_PHOTO_SAVE:String 	= 'onProfilePhotoSave';
		
		// Размер окна приложения был изменен. 
		public static const WINDOW_RESIZED:String 		= 'onWindowResized';
		
		// Изменяется значение хеша после символа # в адресной строке браузера.
		// Данное событие происходит всегда при запуске приложения.
		public static const LOCATION_CHANGED:String 	= 'onLocationChanged';
		
		// Окно с приложением теряет фокус.
		public static const WINDOW_BLUR:String 			= 'onWindowBlur';
		
		// Окно с приложением получает фокус.
		public static const WINDOW_FOCUS:String 		= 'onWindowFocus';
		
		// Пользователь переносит указатель мыши за пределы окна приложения.
		public static const MOUSE_LEAVE:String 			= 'onMouseLeave';
		
		private var _parameters:Object;
		
		/**
		 * 
		 * @param	type
		 * @param	parameters
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function VKWrapperEvent(type:String, parameters:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_parameters = parameters;
		}
		
		/**
		 * Битовая маска выставленных значений настроек. 
		 */
		public function get permissions():Number { return _parameters.settings; }
		
		/**
		 * Текущий баланс пользователя в сотых долях голоса. 
		 * Этот параметр можно использовать только для вывода пользователю. 
		 * Достоверность баланса всегда нужно проверять с помощью метода secure.getBalance.
		 */
		public function get balance():Number { return _parameters.balance; }
		
		/**
		 * Новые ширина приложения в пикселах.
		 */
		public function get width():Number { return _parameters.width; }
		
		/**
		 * Новая высота приложения в пикселах.
		 */
		public function get height():Number { return _parameters.height; }
		
		/**
		 * Значение хеша после символа # в адресной строке браузера.
		 */
		public function get location():String { return _parameters.location; }
		
	}

}