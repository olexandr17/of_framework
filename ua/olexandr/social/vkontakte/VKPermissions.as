package ua.olexandr.social.vkontakte {
	/**
	 * ...
	 * @author Olexandr Fedorow
	 */
	public class VKPermissions {
		
		private static const NOTIFY:int = 1;
		private static const FRIENDS:int = 2;
		private static const PHOTOS:int = 4;
		private static const AUDIO:int = 8;
		private static const VIDEO:int = 16;
		private static const OFFERS:int = 32;
		private static const QUESTIONS:int = 64;
		private static const PAGES:int = 128;
		private static const MENU_LINK:int = 256;
		private static const STATUS:int = 1024;
		private static const NOTES:int = 2048;
		private static const MESSAGES:int = 4096;
		private static const WALL:int = 8192;
		private static const ADS:int = 32768;
		private static const OFFLINE:int = 65536;
		private static const DOCS:int = 131072;
		private static const GROUPS:int = 262144;
		private static const NOTIFICATIONS:int = 524288;
		private static const STATS:int = 1048576;
		private static const EMAIL:int = 4194304;
		
		
		/**
		 * Пользователь разрешил отправлять ему уведомления.
		 */
		public var notify:Boolean;
		/**
		 * Доступ к друзьям.
		 */
		public var friends:Boolean;
		/**
		 * Доступ к фотографиям.
		 */
		public var photos:Boolean;
		/**
		 * Доступ к аудиозаписям.
		 */
		public var audio:Boolean;
		/**
		 * Доступ к видеозаписям.
		 */
		public var video:Boolean;
		/**
		 * Доступ к предложениям (устаревшие методы).
		 */
		public var offers:Boolean;
		/**
		 * Доступ к вопросам (устаревшие методы).
		 */
		public var questions:Boolean;
		/**
		 * Доступ к wiki - страницам.
		 */
		public var pages:Boolean;
		/**
		 * Добавление ссылки на приложение в меню слева.
		 */
		public var menu_link:Boolean;
		/**
		 * Доступ к статусу пользователя.
		 */
		public var status:Boolean;
		/**
		 * Доступ к заметкам пользователя.
		 */
		public var notes:Boolean;
		/**
		 * (для Standalone-приложений) Доступ к расширенным методам работы с сообщениями.
		 */
		public var messages:Boolean;
		/**
		 * Доступ к обычным и расширенным методам работы со стеной. 
		 */
		public var wall:Boolean;
		/**
		 * Доступ к расширенным методам работы с рекламным API.
		 */
		public var ads:Boolean;
		/**
		 * Доступ к API в любое время со стороннего сервера (при использовании этой опции параметр expires_in, возвращаемый вместе с access_token, содержит 0 — токен бессрочный).
		 */
		public var offline:Boolean;
		/**
		 * Доступ к документам.
		 */
		public var docs:Boolean;
		/**
		 * Доступ к группам пользователя.
		 */
		public var groups:Boolean;
		/**
		 * Доступ к оповещениям об ответах пользователю.
		 */
		public var notifications:Boolean;
		/**
		 * Доступ к статистике групп и приложений пользователя, администратором которых он является.
		 */
		public var stats:Boolean;
		/**
		 * Доступ к email пользователя. Доступно только для сайтов.
		 */
		public var email:Boolean;
		
		/**
		 * 
		 * @param	value
		 */
		public function VKPermissions(value:int = 0) {
			notify = Boolean(value & NOTIFY);
			friends = Boolean(value & FRIENDS);
			photos = Boolean(value & PHOTOS);
			audio = Boolean(value & AUDIO);
			video = Boolean(value & VIDEO);
			offers = Boolean(value & OFFERS);
			questions = Boolean(value & QUESTIONS);
			pages = Boolean(value & PAGES);
			menu_link = Boolean(value & MENU_LINK);
			status = Boolean(value & STATUS);
			notes = Boolean(value & NOTES);
			messages = Boolean(value & MESSAGES);
			wall = Boolean(value & WALL);
			ads = Boolean(value & ADS);
			offline = Boolean(value & OFFLINE);
			docs = Boolean(value & DOCS);
			groups = Boolean(value & GROUPS);
			notifications = Boolean(value & NOTIFICATIONS);
			stats = Boolean(value & STATS);
			email = Boolean(value & EMAIL);
		}
		
		/**
		 * Собрать битовую маску
		 * @return
		 */
		public function merge():int {
			var _res:int = 0;
			
			if (notify)
				_res |= NOTIFY;
			if (friends)
				_res |= FRIENDS;
			if (photos)
				_res |= PHOTOS;
			if (audio)
				_res |= AUDIO;
			if (video)
				_res |= VIDEO;
			if (offers)
				_res |= OFFERS;
			if (questions)
				_res |= QUESTIONS;
			if (pages)
				_res |= PAGES;
			if (menu_link)
				_res |= MENU_LINK;
			if (status)
				_res |= STATUS;
			if (notes)
				_res |= NOTES;
			if (messages)
				_res |= MESSAGES;
			if (wall)
				_res |= WALL;
			if (ads)
				_res |= ADS;
			if (offline)
				_res |= OFFLINE;
			if (docs)
				_res |= DOCS;
			if (groups)
				_res |= GROUPS;
			if (notifications)
				_res |= NOTIFICATIONS;
			if (stats)
				_res |= STATS;
			if (email)
				_res |= EMAIL;
			
			return _res;
		}
		
		
		public function toString():String {
			var _res:Array = [];
			
			if (notify)
				_res.push("notify");
			if (friends)
				_res.push("friends");
			if (photos)
				_res.push("photos");
			if (audio)
				_res.push("audio");
			if (video)
				_res.push("video");
			if (offers)
				_res.push("offers");
			if (questions)
				_res.push("questions");
			if (pages)
				_res.push("pages");
			if (menu_link)
				_res.push("menu_link");
			if (status)
				_res.push("status");
			if (notes)
				_res.push("notes");
			if (messages)
				_res.push("messages");
			if (wall)
				_res.push("wall");
			if (ads)
				_res.push("ads");
			if (offline)
				_res.push("offline");
			if (docs)
				_res.push("docs");
			if (groups)
				_res.push("groups");
			if (notifications)
				_res.push("notifications");
			if (stats)
				_res.push("stats");
			if (email)
				_res.push("email");
		
			return "[VKPermissions " + _res.join(",") + "]";
		}
		
	}

}