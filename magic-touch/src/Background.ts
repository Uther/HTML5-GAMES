/*
 * 游戏场景绘制类
 * @jetty
 */ 
class Background extends egret.DisplayObjectContainer{
    public constructor()
    {
        super();

        this.init();
    }

    private _txt:egret.BitmapText;
    private _cnt: egret.TextField;
    private _gold: egret.TextField;
    private _top: egret.TextField;
    private init()
    {
        //天空
        var bg:egret.Bitmap = new egret.Bitmap();
        bg.texture = RES.getRes("sky_00_png");
        bg.width = Data.getStageW();
        bg.height = Data.getStageH();
        this.addChild(bg);

        //墙
        var ground:egret.Bitmap = new egret.Bitmap();
        ground.texture = RES.getRes("jousting_wall_png");
        ground.width = Data.getStageW();
        ground.y = Data.getStageH() - ground.height/2;
        this.addChild( ground );

        //左边塔楼
        var tl:egret.Bitmap = new egret.Bitmap();
        tl.texture = RES.getRes("turret_left_png");
        tl.x = -20;
        tl.y = Data.getStageH() - tl.height - 50;;
        this.addChildAt(tl,1);

        //右边塔楼
        var tr:egret.Bitmap = new egret.Bitmap();
        tr.texture = RES.getRes("turret_right_png");
        tr.x = Data.getStageW() - tr.width + 20;
        tr.y = Data.getStageH() - tr.height- 50;
        this.addChildAt(tr,1);
        
        //塔尖
        var m1:egret.Bitmap = new egret.Bitmap();
        m1.texture = RES.getRes("ge_cannon_open_22_png");
        m1.x = tl.x-5 ;
        m1.y = tl.y - m1.height +60;
        this.addChild(m1);

        //塔尖
        var m2:egret.Bitmap = new egret.Bitmap();
        m2.texture = RES.getRes("ge_cannon_open_22_png");
        m2.x = tr.x-5;
        m2.y = tr.y - m2.height +60;
        this.addChild(m2);

        //分数
        this._txt = new egret.BitmapText();
        this._txt.font = RES.getRes("num_fnt");
        this._txt.letterSpacing = 5;
        this._txt.width = Data.getStageW();
        this._txt.textAlign = "center";
        this._txt.y = Data.getStageH() / 2 - 60;
        this._txt.text = Data.score.toString();
        this.addChild(this._txt);
        
        //倒计时
        this._cnt = new egret.TextField();
        this._cnt.text = "60";
        this._cnt.width = Data.getStageW();
        this._cnt.fontFamily = "黑体";
        this._cnt.textAlign = "center";
        this._cnt.bold = true;
        this._cnt.y = 10;
        this.addChild(this._cnt);
        this._cnt.visible = false;
        
        //金币
        this._gold = new egret.TextField();
        this._gold.text = "金币:"+Data.gold;
        this._gold.width = Data.getStageW();
        this._gold.textAlign = "left";
        this._gold.fontFamily = "黑体";
        this._gold.bold = true;
        this._gold.x = 10;
        this._gold.y = Data.getStageH() - 40;
        this.addChild(this._gold);
        
        //倒计时
        this._top = new egret.TextField();
        this._top.text = "最高分："+Data.top.toString();
        this._top.width = Data.getStageW();
        this._top.fontFamily = "黑体";
        this._top.bold = true;
        this._top.y = 10;
        this._top.x = 10;
        this.addChild(this._top);
        this._top.visible = false;
        
    }
    
    public top(s:boolean) 
    { 
        if(Data.mode == 1) {
            this._top.text = "最高分：" + Data.top.toString();
        } else { 
            this._top.text = "最高分：" + Data.top2.toString();
        }
        if(s) {
            this._top.visible = true;
        } else { 
            this._top.visible = false;
        }
        
    }
    //分数和金币数更新
    public update()
    {
        this._txt.text = Data.score.toString();
        this._gold.text = "金币:" + Data.gold;
        Data.initGold(2);
    }
    //倒计时更新
    public countDown(e:boolean) 
    { 
        this._cnt.visible = e;
        this._cnt.text = Data.count.toString();  
    }
}