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
	
	public class bake extends groundUI{
		//物理引擎相关
		// private var Matter:Object = Browser.window.Matter;
		// private var LayaRender:Object = Browser.window.LayaRender;
		// private var engine:*;

		// private var ball:Sprite;//足球
		// private var ballSize:Number = 40;//足球
		// private var gate:Sprite;//球门
		private var players:Array = [];//场上球员
		private var playerSize:Array = [40,40];//球员尺寸
		private var playerPos:Array = [[450,30],
			[150,200],[300,200],[450,200],
			[250,300],[400,300],
			[150,400],[300,400],[450,400],
			[250,500],[400,500]];//人员间隔
		private var goal:Number = 0;//得分
		private var groudSize:Array = [0, 0, 600, 800]; //左上右下x,y,tx,ty
		
		private var initialPlayerAmount:int = 11;//球员个数
		private var vx:Number = 0, vy:Number = 0;

		private var sizeW:Number = Laya.stage.width;//宽
		private var sizeH:Number = Laya.stage.height;//高
		
		public function Ground()
		{
			Laya.init(640, 960, WebGL);
			this.rotation = 45;
			// 初始化球员
			initPlayer();
			//初始化球
			// initBall();
			//初始化球门
			// initGate();
			this.ground.rotation = 45;
			// 监视加速器状态
			Accelerator.instance.on(Event.CHANGE, this, monitorAccelerator);
			// 游戏循环
			Laya.timer.frameLoop(1, this, animate);
			//初始化物理引擎
			// initMatter();
			
		}

		// private function initMatter():void{
		// 	var gameWorld:Sprite = new Sprite();
		// 	this.ground.addChild(gameWorld)
		// 	// Laya.stage.addChild(gameWorld);
			
		// 	// 初始化物理引擎
		// 	engine = Matter.Engine.create({enableSleeping: true});
		// 	var render = LayaRender.create({engine: engine, container: gameWorld, width: sizeW, height: sizeH, options: {wireframes: false}});
		// 	Matter.Engine.run(engine);
		// }
		
		private function initPlayer():void
		{
			for (var i:int = 0; i < initialPlayerAmount; i++)
			{
				addPlayer();
			}
		}

		// private function initBall():void
		// {
		// 	ball = new Sprite();
		// 	this.ground.addChild(ball);
		// 	// Laya.stage.addChild(ball);

		// 	ball.size(ballSize,ballSize);
		// 	ball.pivot(ballSize/2, ballSize/2);

		// 	// Laya.stage.on(Event.MOUSE_MOVE, this, mouseMove);
			
		// 	ball.graphics.drawRect(0, 0, ballSize, ballSize, "#00BFFF");

		// 	ballStartPos();
		// }

		// private function initGate():void
		// {
		// 	gate = new Sprite();
		// 	this.ground.addChild(gate);
		// 	// Laya.stage.addChild(gate);
		// 	gate.size(100,30);
		// 	gate.graphics.drawRect(0, 0, 100, 30, "#00BFFF");

		// 	gate.x = 300;
		// 	gate.y = 0;
		// }

		private function mouseMove(e):void
		{
			vx = Laya.stage.mouseX;
			vy = Laya.stage.mouseY;
		}
		
		
		private function addPlayer():void
		{
			var player:Player = new Player(playerSize[0], playerSize[1]);
			// Laya.stage.addChildAt(player, 0);
			this.ground.addChild(player);
			var count:Number = players.length;
			if (count > 0)
			{
				var pos:Array = playerPos[count];

				player.x = pos[0];
				player.y = pos[1];
			} else {
				//守门员
				player.x = (sizeW - playerSize[0])/2;
				player.y = 100;//球门高度+头部栏高度
			}
			// Matter.World.add(engine.world, player);
			
			players.push(player);
		}
		
		private function animate():void
		{
			ball.x += vx;
			ball.y += vy;
			limitMoveGate()
			limitMoveRange();
			for(var i:Number = 0;i < players.length; i++){
				var player:Player = players[i];
				limitMovePlayer([player.x,player.y]);
			}
		}
		//球员碰撞检测 [x,y]
		private function limitMovePlayer(range:Array):void 
		{
			var len:Number = (ball.width + playerSize[0])/2;
			var cx:Number = Math.abs(ball.x - range[0]);
			var cy:Number = Math.abs(ball.y - range[1]);
			//碰撞了
			if(cx < len && cy < len){
				if(cx > cy){
					if(ball.x > range[0]){
						ball.x = range[0] + len;
					}else{
						ball.x = range[0] - len;
					}
				}else{
					if(ball.y > range[1]){
						ball.y = range[1] + len;
					}else{
						ball.y = range[1] - len;
					}
				}
			}
		}
		//进球检测
		private function limitMoveGate():void
		{
			// console.log(ball.x,"gatex:"+gate.x,"gatey:"+gate.y,"gatew:"+gate.width);
			if(ball.y < gate.height + ball.width / 2){
				//完全进入
				if(ball.x - ball.width/2 > gate.x && ball.x + ball.width / 2 < gate.x + gate.width){
					if(ball.y < gate.height){
						alert('进球了！');
						ballStartPos();
					}
				}else{
					//左边柱
					if(gate.x > ball.x && gate.x - ball.x < ball.width / 2){
						ball.x = gate.x - ball.width / 2;
					}
					//右边柱
					if(ball.x > gate.x && ball.x - gate.width - gate.x < ball.width / 2){
						ball.x = gate.width + gate.x + ball.width / 2;
					}
				} 
			}
		}
		//边界检测
		private function limitMoveRange():void
		{
			if (ball.x < groudSize[0])
				ball.x = groudSize[0];
			else if (ball.x > groudSize[2])
				ball.x = groudSize[2];
			if (ball.y < groudSize[1])
				ball.y = groudSize[1];
			else if (ball.y > groudSize[3])
				ball.y = groudSize[3];
		}
		
		//初始化求的位置
		private function ballStartPos():void
		{
			ball.x = sizeW  / 2;
			ball.y = (sizeH - 50);
		}

		private function monitorAccelerator(acceleration:AccelerationInfo, accelerationIncludingGravity:AccelerationInfo, rotationRate:Object, interval:Number):void
		{
			vx = accelerationIncludingGravity.x;
			vy = accelerationIncludingGravity.y;
		}
	}
}