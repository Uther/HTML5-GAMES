/*
 * 游戏控制类
 * @jetty
 */ 
class Game
{
    private _layer:egret.DisplayObjectContainer;
    public constructor(layer:egret.DisplayObjectContainer)
    {
        this._layer = layer;
        this.init();
    }

    private _gesture:Gesture;
    private _gestureShape:egret.Shape;
    private init()
    {
        this.drawBg();//绘制游戏背景
        Data.stage.addEventListener("gameover",this.gameover,this);//添加游戏结束事件回调监听
        Data.stage.addEventListener("earthquake",this.earthquake,this);//添加机器人落地后震动事件回调监听
        this._gestureShape = new egret.Shape();
        this._layer.addChild(this._gestureShape);
        this._gesture = new Gesture();//添加手势监听
    }
    //初始化游戏控制参数
    private initGame() 
    {
        Data.gameing = true;
        this._pause.visible = true;
        this._out.visible = true;
        this._wh.visible = false;
        this._gesture.addEvent(this._gestureShape);//添加手势监听
    }

    private _background:Background;
    private _pause: egret.Bitmap;
    private _out: egret.Bitmap;
    private _wh: egret.Bitmap;
    private drawBg()
    {
        this._background = new Background();//游戏背景绘制类
        this._layer.addChild( this._background );
        this.addKill();
        //暂停按钮
        var ps = new egret.Bitmap();
        ps.texture = RES.getRes("pause_png");
        ps.width = 97;
        ps.height = 97;
        ps.y = 10;
        ps.x = Data.getStageW() - 107;
        this._layer.addChild(ps);
        this._pause = ps;
        this._pause.touchEnabled = true;
        this._pause.addEventListener(egret.TouchEvent.TOUCH_TAP,this.pause,this);
        this._pause.visible = false;
        //退出按钮
        var ot = new egret.Bitmap();
        ot.texture = RES.getRes("out_png");
        ot.width = 97;
        ot.height = 97;
        ot.y = 10;
        ot.x = Data.getStageW() - 220;
        this._layer.addChild(ot);
        this._out = ot;
        this._out.touchEnabled = true;
        this._out.addEventListener(egret.TouchEvent.TOUCH_TAP,this.out,this);
        this._out.visible = false;
        //帮助按钮
        var wh = new egret.Bitmap();
        wh.texture = RES.getRes("wh_png");
        wh.width = 52;
        wh.height = 54;
        wh.y = 10;
        wh.x = Data.getStageW() - 62;
        this._layer.addChild(wh);
        wh.touchEnabled = true;
        wh.addEventListener(egret.TouchEvent.TOUCH_TAP,function() { 
            alert("根据气球图案一笔画出，气球爆炸后得分。");
        },this);
        this._wh = wh;
    }
    //退出游戏，还有些bug
    private out() { 
        Data.gameing = false;
        this._pause.visible = false;
        this._out.visible = false;
        this._wh.visible = true;
        this._background.countDown(false);
        this._time.stop();//停止机器人下落
        this._gesture.removeEvent();//移除手势监听
        this.removeBg();
        this.modePick();
    }

    //暂停按钮
    private pause() { 
        if(Data.pause) {
            this._time.start();
            Data.pause = false;
            this._gesture.addEvent(this._gestureShape);
            for(var i = 0;i < Data.robots.length;i++) { 
                Data.robots[i].remove();
            }
        } else { 
            this._time.stop();
            Data.pause = true;
            this._gesture.removeEvent();
            for(var i = 0;i < Data.robots.length;i++) {
                Data.robots[i].stop();
            }
        }
    }
    //开始游戏
    private _time:egret.Timer;
    public start()
    {
        this.initGame();//初始化游戏参数
        
        this._background.top(true);
        if(Data.mode == 1) {
            //普通模式
            this._time = new egret.Timer(1000,0);
            this._time.addEventListener(egret.TimerEvent.TIMER,this.create,this);
            this._time.start();
            console.log("mode1");
        } else { 
            //计时模式
            this._time = new egret.Timer(1000,60);
            this._time.addEventListener(egret.TimerEvent.TIMER,this.create,this);
            this._time.addEventListener(egret.TimerEvent.TIMER_COMPLETE,this.gameover,this);//到点后游戏结束
            this._time.start();
            console.log("mode2");
        }
    }
    //生成机器人
    private create(evt:egret.TimerEvent)
    {
        if(Data.mode == 2) { 
            Data.count--;
            this._background.countDown(true);
        }
        var fm:FlyMan = new FlyMan();
        Data.robots.push(fm);
        this._layer.addChild(fm);
    }
    //游戏结束
    private gameover(evt:egret.Event)
    {
        Data.gameing = false;
        this._pause.visible = false;
        this._out.visible = false;
        this._wh.visible = true;
        this._background.countDown(false);
        Data.sfail.play(0,1);//播放结束音效
        this._time.stop();//停止机器人下落
        this._gesture.removeEvent();//移除手势监听
        var score = Data.score;
        if(score > Data.top && Data.mode == 1) { 
            Data.top = score;
            Data.initTop(2);
            this._background.top(false);
        }
        if(score > Data.top2 && Data.mode == 2) {
            Data.top2 = score;
            Data.initTop2(2);
            this._background.top(false);
        }
        this.removeBg();
        var over:Over = new Over(score);//弹出
        this._layer.addChild(over);
        this.show(over);
        
        over.addEventListener("again",this.modePick,this);
    }
    //弹出窗口动效
    private show(obj) { 
        obj.horizontalCenter = 1;
        //添加遮罩
        var ty = (Data.getStageH() - obj.height) / 2;
        obj.x = (Data.getStageW() - obj.width) / 2;
        obj.y = ty;
        obj.scaleX = obj.scaleY = 0.9;
        //        bounceOut  backInOut  backOut  sineOut
        egret.Tween.get(obj,{ loop: false }).to({ scaleX: 1,scaleY: 1 },500,egret.Ease.backInOut);
    }
    /*
     * 结束后清屏
     */ 
    private removeBg() 
    {
        this.removeRobot();
        Data.score = 0;
        Data.count = 60;
        this._background.update();
    }
    //移除机器人
    private removeRobot() 
    { 
        //数据初始化
        var len = Data.robots.length;
        for(var i = 0;i < len;i++) {
            this._layer.removeChild(Data.robots[i]);
        }
        Data.robots = [];
    }
    /*
     * 模式选择
     */
    private _mode: Box;
    public modePick() {
        this._mode = new Box();
        this._layer.addChild(this._mode);
        this.show(this._mode);
        
        this._mode.addEventListener("mode",this.start,this);
    }
    /*
     * 清屏道具
     */ 
    private kill:egret.Bitmap;
    private addKill() 
    { 
        var bg: egret.Bitmap = new egret.Bitmap();
        bg.texture = RES.getRes("s_all_png");
        bg.width = 93;
        bg.height = 94;
        bg.x = Data.getStageW() - 113;
        bg.y = Data.getStageH() - 94 - 40;
        bg.touchEnabled = true;
        this._layer.addChild(bg);
        
        var cost: egret.TextField = new egret.TextField();
        cost.width = Data.getStageW() - 10;
        cost.text = "50金/次";
        cost.bold = true;
        cost.fontFamily = "黑体";
        cost.height = 200;
        cost.textAlign = "right";
        cost.y = Data.getStageH() - 40;
        this._layer.addChild(cost);
        
        this.kill = bg;
        this.kill.addEventListener(egret.TouchEvent.TOUCH_TAP,this.funcKill,this);
    }
    //清屏
    private funcKill() { 
        if(Data.gameing && Data.gold > 50) {
            Data.gold -= 50;
            Data.stool.play(0,1);//道具使用音效播放
            this._background.update();
            var len = Data.robots.length;
            for(var i = 0;i < len;i++) {
                Data.robots[i].kill();
            }
        } else { 
            alert("游戏中点击使用");
        }
    }
    //落地后震动
    private earthquake(evt:egret.Event)
    {
        this._background.update();
        egret.Tween.get(this._layer).to({x:5,y:5},50).to({x:-5,y:5},50).to({x:5,y:-5},50).to({x:0,y:0},50);
    }

}