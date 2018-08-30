package {
	import laya.utils.Handler;
	import laya.webgl.WebGL;
	import ui.test.football.groundUI;
	import laya.display.Sprite;
	import laya.device.motion.AccelerationInfo
	import laya.device.motion.Accelerator;
	import laya.events.Event;
	import laya.ui.Image;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.net.HttpRequest;
	import laya.ui.Button;
	
	public class Ground extends groundUI{
		private var count:Number = 60;//倒计时
		private var groudSize:Array = [0, 0, -2243, -676]; //左上右下x,y,tx,ty
		private var players:Array = [];
		private var vx:Number = 0, vy:Number = 0;

		private var pointlen:Number = 40;//判定点与对象的高度差
		private var bonceframecount:Number = 0;//回弹掉帧计数
		private var moveframecount:Number = 0;//计数
		private var movedir:Number = 1;//移动方向
		private var acc:Number = 1;//球自转速度
		
		public function Ground()
		{
			// 监视加速器状态
			Accelerator.instance.on(Event.CHANGE, this, monitorAccelerator);
			// 游戏循环
			Laya.timer.frameLoop(1, this, animate);
			//倒计时
			Laya.timer.loop(1000, this, countDown);
			//开球
			startman.on(Event.CLICK, this, start);
			//初始化
			init();
		}

		private function init():void{
			if(!Hconfig._versionshow){
				version.removeSelf();
			}else{
				version.text = Hconfig._version;
			}
			Hconfig._goals = 0;
			count = 60;
			countlabel.text = ""+count;
			goalslabel.text = Hconfig._goals+"-0";
			reset()
		}
		
		private function start():void {
			tip.removeSelf()
			Hconfig.playSound("res/sound/13_01.mp3");
			// Laya.timer.once(1000, this, showStart);
			Laya.timer.once(1000, this, startBall);
		}


		private function showStart():void {
			var startpage:StartScene = new StartScene();
			this.addChild(startpage);
		}

		private function startBall():void {
			Tween.to(board,{bottom:0}, 1000, Ease.backOut,null,100);
			Tween.to(startman,{rotation:-10}, 1000, Ease.backOut,Handler.create(this,pullIt),500);
		}

		private function pullIt():void {
			Tween.to(startman,{rotation:0}, 1000, Ease.backOut,Handler.create(this,startGame),100);
		}

		private function startGame():void {
			startman.removeSelf()
			Hconfig._gaming = true;
		}

		private function countDown():void {
			if(Hconfig._gaming){
				countlabel.text = count < 10 ? "0"+count : ""+count;
				count--;
				if(count < 0){
					Hconfig._gaming = false;
					Hconfig.checkData('score',Hconfig._goals,4);
					Hconfig.playSound("res/sound/13_02.mp3")
					Laya.timer.once(2000, this, jump);
				}
			}
		}

		// private function gameover():void{
		// 	var openid:String = LocalStorage.getItem('openid');
		// 	var hr:HttpRequest = new HttpRequest();
		// 	hr.once(Event.COMPLETE, this, this.jump);
		// 	hr.once(Event.ERROR, this, this.jump);
		// 	hr.send('/woo/action.php', 'openid='+openid+'&score='+this.goals, 'post', 'json');	
		// }

		private function jump():void{
			__JS__("parent.jump()");
			// Browser.window.location.href = "http://mp.softouchco.com/app/index.php?i=1&c=entry&rid=189&do=result&m=ewei_takephotoa";
		}

		//初始化求的位置
		private function reset():void
		{
			ground.x = -1743;
			ground.y = -374;
			ball.x = 2108;
			ball.y = 1149;
		}
		
		private function animate():void
		{
			if(!Hconfig._gaming) {
				return
			}
			if(bonceframecount > 0){
				bonceframecount--
				vx = -vx;
				vy = -vy;
			}	
			ball.x += vx;
			ball.y += vy;
			ground.x -= vx;
			ground.y -= vy/2;

			if(Hconfig._gaming){
				ball.rotation += acc;
			}
			moveGateMan()
			limitGround(); //场景四个边框检测
			checkLine(); //球边线检测
			//球员碰撞检测
			for(var i:Number = 0;i < 13; i++){
				var player:Button = this.getPlayer(i);
				limitMovePlayer(player);
			}
		}
		//守门员移动
		private function moveGateMan():void{
			var movesize:Number = Math.ceil(Math.random()*10)
			if(moveframecount < 0){
				moveframecount = Hconfig._moveframe
				movedir = (movesize > 5) ? 1 : -1;
			}else{
				moveframecount--;
			}

			gateman.x -= movesize*movedir;
			
			if(gateman.x < 780){
				gateman.x = 780
			}
			if(gateman.x > 1233){
				gateman.x = 1233
			}
			gateman.y = 1065 - 0.53 * gateman.x
			play0.x = gateman.x
			play0.y = gateman.y + pointlen;
		}

		private function limitGround():void{
			if(ground.x < groudSize[2]){
				ground.x = groudSize[2];
			}
			if(ground.x > 0){
				ground.x = 0;
			}
			if(ground.y < groudSize[3]){
				ground.y = groudSize[3];
			}
			if(ground.y > 0){
				ground.y = 0
			}
		}
		//球员碰撞检测 [x,y]
		private function limitMovePlayer(player:Button):void 
		{
			var wx:Number = (ball.width + player.width)/2;
			var hy:Number = (ball.height + player.height)/2;
			var cx:Number = Math.abs(ball.x - player.x);
			var cy:Number = Math.abs(ball.y - player.y);
			var zhuang:Boolean = false;
			//碰撞了
			if(cx < wx && cy < hy){
				zhuang = true;
				ball.rotation -= 2*acc;
				bonceframecount = Hconfig._bonceframe;
				if(cx > cy){
					if(ball.x > player.x){
						ball.x = player.x + wx;
					}else{
						ball.x = player.x - wx;
					}
					ground.x += vx;
				}else{
					if(ball.y > player.y){
						ball.y = player.y + hy;
					}else{
						ball.y = player.y - hy;
					}
					ground.y += vy/2;
				}
			}
		}
		
		private function checkLine():void {
			var out:Boolean = false;
			if(ball.x > 342 && ball.x < 1607 && ball.y > 197 && ball.y < 917) {
				if(this.leftline()){
					out = true
					if(ball.x > 768 && ball.x < 1233 && ball.y > 407 && ball.y < 655){
						var goalpage:Goal = new Goal(); //进球了
						this.addChild(goalpage);
						Hconfig.playSound("res/sound/m4.mp3")
						Hconfig._goals++;
						goalslabel.text = Hconfig._goals+"-0";
					}
				}
			}
			if(ball.x > 342 && ball.x < 1709 && ball.y > 917 && ball.y < 1636){
				if(this.bottomline()){
					out = true;
					// alert('bottom out');
				}
			}
			if(ball.x > 1607 && ball.x < 2883 && ball.y > 197 && ball.y < 870){
				if(this.topline()){
					out = true;
					// alert('top out');
				}
			}
			if(ball.y > 870 && ball.x > 2860){
				out = true
				//alert('right ground out');
			}
			if(ball.x > 1710 && ball.y > 1630){
				out = true
				//alert('bottom ground out');
			}
			if(out){
				reset();
			}
		}

		private function leftline():Boolean {
			return Math.ceil(1065 - 0.53 * ball.x - ball.y) > 10
		}
		private function bottomline():Boolean {
			return Math.ceil(737 + 0.53 * ball.x - ball.y) < 10
		}
		private function topline():Boolean {
			return Math.ceil(0.53*ball.x - 650 - ball.y) > 10
		}

		private function monitorAccelerator(acceleration:AccelerationInfo, accelerationIncludingGravity:AccelerationInfo, rotationRate:Object, interval:Number):void
		{
			vx = accelerationIncludingGravity.x*2;
			vy = accelerationIncludingGravity.y*2;
			if(Hconfig._android){
				vx = -vx;
			}
			acc = Math.abs(vx)*2
			if(Math.abs(vx) < Math.abs(vy)){
				acc = Math.abs(vy)*2
			}
		}

		private function getPlayer(i:int):Button{
			var objs:Array = [play0,play1,play2,play3,play4,play5,play6,play7,play8,play9,play10,pillar1,pillar2];
			return objs[i];
		}
	}
}