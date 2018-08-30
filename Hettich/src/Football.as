package {
	import laya.webgl.WebGL;
	import laya.utils.Handler;
	import laya.net.Loader;

	
	public class Football{

		public static const SCALE_FIXED_WIDTH:String = "fixedheight";

		public function Football()
		{
			new Hconfig();//初始化配置参数
			Laya.init(640, 960,WebGL);
			Laya.stage.scaleMode = SCALE_FIXED_WIDTH;
			
			var urls:Array = [
				{url: "res/atlas/ball.atlas", type: Loader.ATLAS},
				{url: "res/sound/m4.mp3", type: Loader.SOUND},
				{url: "res/sound/13_01.mp3", type: Loader.SOUND},
				{url: "res/sound/13_02.mp3", type: Loader.SOUND},
			];
			
			Laya.loader.retryNum = 0;
			Laya.loader.load(urls,Handler.create(this, onAssetLoaded),Handler.create(this, onLoading, null, false),Loader.TEXT);
		}

		private function onAssetLoaded():void
		{
			var ground:Ground = new Ground();
			Laya.stage.addChild(ground);
			// 使用texture
			trace("加载结束");
		}
		
		// 加载进度侦听器
		private function onLoading(progress:Number):void
		{
			trace("加载进度: " + progress);
		}
		
		private function onError(err:String):void
		{
			trace("加载失败: " + err);
		}
		
	}
}