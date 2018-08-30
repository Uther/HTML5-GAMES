package {
	import laya.utils.Handler;
	import laya.webgl.WebGL;
	import ui.test.football.groundUI;
	import laya.display.Sprite;
	import laya.device.motion.AccelerationInfo
	import laya.device.motion.Accelerator;
	import laya.events.Event;
	import laya.renders.Render;
	import laya.utils.Browser;
	import laya.ui.Image;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.net.LocalStorage;
	import laya.net.HttpRequest;
	
	public class bake2 extends groundUI{
		private var goals:Number = 0;//得分
		private var count:Number = 60;//倒计时
		private var groudSize:Array = [0, 0, -2243, -676]; //左上右下x,y,tx,ty
		private var moveSize:Array = [0, 0, 1444, 1872];
		private var players:Array = [];
		private var vx:Number = 0, vy:Number = 0;

		private var sw:Number = Laya.stage.width;//宽
		private var sh:Number = Laya.stage.height;//高
		public var gaming:Boolean = false;
		
		public function bake2()
		{
			// 初始化球员
			init();
			// 监视加速器状态
			Accelerator.instance.on(Event.CHANGE, this, monitorAccelerator);
			// 游戏循环
			Laya.timer.frameLoop(1, this, animate);

			Laya.timer.loop(1000, this, countDown);

			this.ground.on(Event.MOUSE_DOWN, this, onStartDrag)

			this.ground.on(Event.CLICK, this, onClick)

			this.ball.on(Event.MOUSE_DOWN, this, onStartDragBall)
			//初始化物理引擎
			Laya.timer.once(2000, this, startBall);
		}

		private function onClick(e):void {
			console.log(this.mouseX,this.mouseY)
		}

		private function startCount():void {

		}

		private function startBall():void {
			Tween.to(this.startman,{rotation:-10}, 1000, Ease.backOut,Handler.create(this,pullIt),500);
		}

		private function pullIt():void {
			Tween.to(this.startman,{rotation:0}, 1000, Ease.backOut,Handler.create(this,startGame),100);
		}

		private function boardUp():void {
			Tween.to(this.board,{bottom:0}, 1000, Ease.backOut,null,100);
		}

		private function startGame():void {
			this.gaming = true;
		}

		private function countDown():void {
			if(this.gaming){

				this.countlabel.text = count < 10 ? "0"+count : ""+count;
				count--;
				if(count < 0){
					this.gaming = false;
					this.gameover()
				}
			}
		}

		private function gameover():void{
			var openid:String = LocalStorage.getItem('openid');
			var hr:HttpRequest = new HttpRequest();
			hr.once(Event.COMPLETE, this, this.jump);
			hr.once(Event.ERROR, this, this.jump);
			hr.send('/woo/action.php', 'openid='+openid+'&score='+this.goals, 'post', 'json');	
		}

		private function jump():void{
			Browser.window.location.href = "http://mp.softouchco.com/addons/ewei_takephotoa/template/mobile/result.html";
		}

		private function onStartDrag(e:Event=null):void{
			this.ground.startDrag(null, true, 100);
			// console.log(this.ground.x,this.ground.y);
		}

		private function onStartDragBall(e:Event=null):void{
			this.ball.startDrag(null, true, 100);
			// console.log(this.ball.x,this.ball.y);
		}

		private function init():void {
			ballStartPos()
		}

		//初始化求的位置
		private function ballStartPos():void
		{
			this.ground.x = -743;
			this.ground.y = -274;
			ball.x = 2108;
			ball.y = 1149;
		}
		
		private function animate():void
		{
			
			ball.x += vx;
			ball.y += vy;
			this.ground.x -= vy;
			this.ground.y -= vy/2;

			// if(ball.x > 600) {
			// 	this.ground.y -= vx;
			// }else{
			// 	this.ground.y = - (ball.x + 896);
			// }
			// if(ball.y < 300) {
			// 	this.ground.y = -100
			// 	this.ground.x -= vy;
			// }else{
			// 	this.ground.x = - (ball.y + 302);
			// }
			// if(this.ground.y >= 0){
			// 	ball.y += vy 
			// }else{
			// 	ball.y = Math.abs(this.ground.y - sh + 302 + 200)
			// }
			// ball.x = Math.abs(this.ground.x - sw + 892 +  200)
			if(this.gaming){
				ball.rotation += 1;
			}
			limitGround();
			limitMoveGate();
			checkOut();
			// limitMoveRange();
			
			for(var i:Number = 0;i < 10; i++){
				var player:Image = this.getPlayer(i);
				limitMovePlayer(player);
			}
		}
		private function limitGround():void{
			if(this.ground.x < groudSize[2]){
				this.ground.x = groudSize[2];
			}
			if(this.ground.x > 0){
				this.ground.x = 0;
			}
			if(this.ground.y < groudSize[3]){
				this.ground.y = groudSize[3];
			}
			if(this.ground.y > 0){
				this.ground.y = 0
			}
		}
		//球员碰撞检测 [x,y]
		private function limitMovePlayer(player:Image):void 
		{
			var wx:Number = (ball.width + player.width)/2;
			var hy:Number = (ball.height + player.height)/2;
			var cx:Number = Math.abs(ball.x - player.x);
			var cy:Number = Math.abs(ball.y - player.y);
			var zhuang:Boolean = false;
			//碰撞了
			if(cx < wx && cy < hy){
				if(cx > cy){
					if(ball.x > player.x){
						ball.x = player.x + wx;
						zhuang = true;
					}else{
						ball.x = player.x - wx;
						zhuang = true;
					}
				}else{
					if(ball.y > player.y){
						ball.y = player.y + hy;
						zhuang = true;
					}else{
						ball.y = player.y - hy;
						zhuang = true;
					}
				}
			}
			if(zhuang){
				this.ground.x += vy
			}
		}
		//碰撞检测 [x,y]
		// private function testHit(obj:Image):Boolean 
		// {
		// 	var wx:Number = (ball.width + obj.width)/2;
		// 	var hy:Number = (ball.height + obj.height)/2;
		// 	var cx:Number = Math.abs(ball.x - obj.x);
		// 	var cy:Number = Math.abs(ball.y - obj.y);
		// 	var zhuang:Boolean = false;
		// 	//碰撞了
		// 	if(cx < wx && cy < hy){
		// 		if(cx > cy){
		// 			if(ball.x > obj.x){
		// 				zhuang = true;
		// 			}else{
		// 				zhuang = true;
		// 			}
		// 		}else{
		// 			if(ball.y > obj.y){
		// 				zhuang = true;
		// 			}else{
		// 				zhuang = true;
		// 			}
		// 		}
		// 	}
		// 	return zhuang
		// }
		private function checkOut():void {
			var out:Boolean = false;
			if(ball.x < 1607 && ball.x > 1233 && ball.y < 407 && ball.y > 197){
				if(this.leftline()){
					out = true
					// alert('left top out');
				}
			}
			if(ball.x > 342 && ball.x < 768 && ball.y < 917 && ball.y > 655){
				if(this.leftline()){
					out = true;
					// alert('left bottom out');
					
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
					alert('top out');
				}
			}
			if(out){
				ballStartPos();
			}
		}
		private function limitMoveGate():void {
			if(ball.x > 768 && ball.x < 1233 && ball.y > 407 && ball.y < 655){
				if(this.leftline()){
					var goalpage:Goal = new Goal();
					this.addChild(goalpage);
					this.goals++;
					this.goalslabel.text = goals < 10 ? "0"+goals : ""+goals
					ballStartPos();
				}
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
		//进球检测
		// private function limitMoveGate():void
		// {
		// 	//均判断小于0则成立
		// 	var henter:Number = ball.y - gate.height;
		// 	var htouch:Number = henter - ball.height / 2;
		// 	var wl:Number = gate.x - gate.width / 2 - ball.width / 2;//球门左边
		// 	var wr:Number = gate.x + gate.width / 2 + ball.width / 2;//球门右边
		// 	var bl:Number = ball.x - ball.width / 2;//球左边
		// 	var br:Number = ball.x + ball.width / 2;//球右边
		// 	if(htouch < 0){
		// 		//完全进入
		// 		if(br - wl > ball.width && wr - bl > ball.width){
		// 			if(henter < 0){
		// 				var goalpage:Goal = new Goal();
		// 				this.addChild(goalpage);
		// 				this.goals++;
		// 				this.goalslabel.text = goals < 10 ? "0"+goals : ""+goals
		// 				ballStartPos();
		// 			}
		// 		}else{
		// 			//左边柱
		// 			if(br - wl > 0 && bl - wl < 0){
		// 				ball.x = wl;
		// 			}
		// 			//右边柱
		// 			if(bl - wr < 0 && br - wr > 0){
		// 				ball.x = wr;
		// 			}
		// 		} 
		// 	}
		// }
		//边界检测
		private function limitMoveRange():void
		{
			if (ball.x < moveSize[0])
			// ballStartPos()
				ball.x = moveSize[0];
			else if (ball.x > moveSize[2])
			// ballStartPos()
				ball.x = moveSize[2];
			if (ball.y < moveSize[1])
			// ballStartPos()
				ball.y = moveSize[1];
			else if (ball.y > moveSize[3])
				ball.y = moveSize[3];
				// ballStartPos()
		}
		
		

		private function monitorAccelerator(acceleration:AccelerationInfo, accelerationIncludingGravity:AccelerationInfo, rotationRate:Object, interval:Number):void
		{
			vx = accelerationIncludingGravity.x;
			vy = accelerationIncludingGravity.y;
		}
		private function getGate(i:int):Image {
			var objs:Array = [this.gate1,this.gate2,this.gate3];
			return objs[i];
		}

		private function getPlayer(i:int):Image{
			var objs:Array = [this.play0,this.play1,this.play2,this.play3,this.play4,this.play5,this.play6,this.play7,this.play8,this.play9,this.play10];
			return objs[i];
		}
	}
}