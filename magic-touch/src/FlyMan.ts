/*
 * 机器人类
 * @jetty
 */ 
class FlyMan extends egret.DisplayObjectContainer {
    public constructor() {
        super();
        this.init();
    }

    private _man:egret.MovieClip;
    private _balloon:egret.Bitmap;
    //private _balloonMc:egret.MovieClip;
    private _line:egret.Shape;
    private _type:number;
    private _exp:boolean = false;
    private _speed:number = 0;

    private init() {
        var data = RES.getRes("flyman_action_json");
        var tex = RES.getRes("flyman_action_png");
        console.log("yes: ",tex);
        var mcf:egret.MovieClipDataFactory = new egret.MovieClipDataFactory(data, tex);

        this._man = new egret.MovieClip(mcf.generateMovieClipData("flyman"));
        this.addChild(this._man);



        this._balloon = new egret.Bitmap();
        this._balloon.y = -100;
//
        this.addChild(this._balloon);
//
        //var dd = RES.getRes("balloonmc_json");
        //var tt = RES.getRes("balloonmc_png");
        //var mcf1:egret.MovieClipDataFactory = new egret.MovieClipDataFactory(dd, tt);
        ////var img:egret.Bitmap = new egret.Bitmap();
        //mcf1.generateMovieClipData("abc")
        //img.texture = mcf1.generateMovieClipData("abc").getTextureByFrame(1);
        //this.addChild(img);
        //console.log(dd);
        //console.log(tt);

        //this._balloonMc = new egret.MovieClip(mcf1.generateMovieClipData("abc"));
        //this._balloonMc.x = 100;
        ////this.addChild(this._balloonMc);
        //this._balloonMc.y = this._balloon.y;
        //this.addChild(this._balloonMc);
        //this._balloonMc.visible = false;
        //console.log(this._balloonMc.frameRate);
        //this.addChild( this._balloonMc );
        //this._balloonMc.play(-1);

        this._line = new egret.Shape();
        this._line.graphics.lineStyle(1, 0);
        this._line.graphics.moveTo(0, 0);
        this._line.graphics.lineTo(0, -90);
        this.addChildAt(this._line, 0);

        this.addEventListener(egret.Event.ADDED, this.added, this);

        Data.stage.addEventListener("gameover", this.gameover, this);
        Data.stage.addEventListener("action", this.action, this);
    }

    //添加机器人
    private added(evt:egret.Event):void {

        this._exp = false;
        this.x = 100 + Math.random() * (Data.getStageW() - 200);
        this.y = -100;
        this._type = this.selectType();
        this._balloon.texture = this.getBalloonTexture();
        this._balloon.x = this._balloon.width / 2 * -1;
        this._man.play(-1);

        this.addChild(this._balloon);
        this.addChildAt(this._line,0);

        this._speed = 2 + Math.random() * 4;
        this.addEventListener(egret.Event.ENTER_FRAME, this.move, this);
    }

    //移动机器人
    private move(evt:egret.Event) {
        if (this.y >= Data.getStageH() - 80) {
            //游戏结束
            //console.log("game over");
            this.removeEventListener(egret.Event.ENTER_FRAME, this.move, this);
            if (this._exp) {
                this.removeRob();
                Data.stage.dispatchEvent(new egret.Event("earthquake"));
            }
            else {
                //普通模式掉地上失败，计时模式不处理
                if(Data.mode == 1) {
                    Data.stage.dispatchEvent(new egret.Event("gameover"));
                } else { 
                    this.removeRob();
                }
            }
        }
        this.y += this._speed;
    }
    public stop() { 
        this.removeEventListener(egret.Event.ENTER_FRAME,this.move,this);
    }
    public remove() { 
        this.addEventListener(egret.Event.ENTER_FRAME,this.move,this);
    }
    //移除机器人
    private removeRob() { 
        if(Data.gameing) { 
            this.parent.removeChild(this);
            var i = this.robotInArray();
            Data.robots.splice(i,1);
        }
    }
    //机器人在数组中的位置
    private robotInArray() {
        var index = -1;
        var robArr = Data.robots;
        for(var i = 0;i < robArr.length;i++) {
            if(robArr[i] == this) {
                index = i;
                break;
            }
        }
        return index;
    }
    //随机取值
    private selectType():number {
        return Math.floor(Math.random() * 6);
    }
    //获取气球图片
    private getBalloonTexture():egret.Texture {
        var res;
        switch (this._type) {
            case 0:
                res = RES.getRes("ge_balloon_V_png");
                break;
            case 1:
                res = RES.getRes("ge_balloon_vert-line_png");
                break;
            case 2:
                res = RES.getRes("ge_balloon_horiz-line_png");
                break;
            case 3:
                res = RES.getRes("ge_balloon_delta_png");
                break;
            case 4:
                res = RES.getRes("ge_balloon_gamma_png");
                break;
            case 5:
                res = RES.getRes("ge_balloon_Z_png");
                break;
        }
        return res;
    }
    //游戏结束
    private gameover(evt:egret.Event)
    {
        this._man.stop();
        this.removeEventListener(egret.Event.ENTER_FRAME, this.move, this);
    }
    //道具秒杀机器人
    public kill() { 
        if(this._exp == false) {
            this._exp = true;
            this._speed = 7;
            this.playBalloonMc();
            Data.score++;
            Data.gold++;
        }
    }
    //手势杀怪
    private action(evt:egret.Event)
    {
        if(this._type == Data.type && this._exp==false)
        {
            this._exp = true;
            this._speed = 7;
            this.playBalloonMc();
            Data.score++;
            Data.gold++;
        }
    }
    //机器人被杀后移除气球与线
    private playBalloonMc()
    {
        Data.sboom.play(0,1);
        this.removeChild(this._balloon);
        this.removeChild(this._line);
        //this.addChild(this._balloonMc);
        //this._balloonMc.visible = true;
        //this._balloonMc.play();
    }
}