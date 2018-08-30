package {
	import laya.utils.Browser;
	import laya.media.SoundManager;
	import laya.net.LocalStorage;
	
	public class Hconfig{
		
		public static var _goals:Number = 0;//得分
		public static var _gaming:Boolean = false;

		public static var _android:Boolean = false; //是否安卓
		public static const _versionshow:Boolean = true;//显示版本号
		public static const _sw:Number = Laya.stage.width,_sh:Number = Laya.stage.height;//宽
		public static const _bonceframe:Number = 16;//回弹掉帧
		public static const _moveframe:Number = 10;//守门员连续移动帧数
		public static const _version:String = '0.2.2';//版本号
		public static const _retry:Number = 0;//重试次数
		public static const _debug:Boolean = true;//调试模式
		
		public function Hconfig()
		{
			if(!Browser.onIOS && !Browser.onIPad && !Browser.onIPhone){
				Hconfig._android = true;
			}
			
		}
		public static function playSound(res):void{
			SoundManager.playSound(res,1);
		}

		/* type 1 get 
		* type 2 get array
		* type 3 set array
		* type 4 set
		* */
		public static function checkData(label:String,value,type: Number):String{
			var key: String = label;
			var isIn:Boolean = Hconfig.inExcept(label);
			if(type < 3) {
				var v = LocalStorage.getItem(key);
				if(!v && (Hconfig._debug || isIn)) {
					if(type == 2) {
						LocalStorage.setItem(key,JSON.stringify(value));
					} else {
						LocalStorage.setItem(key,value);
					}
				}
				if(type == 2) {
					return JSON.parse(LocalStorage.getItem(key)) || value;
				}
				return LocalStorage.getItem(key) || value;
			} else if(type == 3) {
				if(Hconfig._debug || isIn) LocalStorage.setItem(key,JSON.stringify(value));
			} else {
				if(Hconfig._debug || isIn) LocalStorage.setItem(key,value);
			}
			return "1";
		}
		public static function inExcept(label):Boolean {
			var isIn:Boolean = false;
			return isIn;
		}
	}
}