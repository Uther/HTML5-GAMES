/*
 * 公共数据类
 * @jetty
 */ 
class Data
{
    //获取场景宽度
    public static getStageW():number
    {
        return egret.MainContext.instance.stage.stageWidth;
    }
    //获取场景高度
    public static getStageH():number
    {
        return egret.MainContext.instance.stage.stageHeight;
    }
    //获取场景对象
    public static get stage()
    {
        return egret.MainContext.instance.stage;
    }
    /*
     * t = 1 读   t = 2 写
     */
    public static initGold(t: number) {
        if(t == 2) {
            egret.localStorage.setItem("gold",String(Data.gold));
        } else {
            var gold = egret.localStorage.getItem("gold");
            if(gold) {
                Data.gold = Number(gold);
            } else {
                Data.gold = 0;
            }
        }
    }
    /*
     * t = 1 读   t = 2 写
     */
    public static initTop(t: number) {
        if(t == 2) {
            egret.localStorage.setItem("top",String(Data.top));
        } else {
            var top = egret.localStorage.getItem("top");
            if(top) {
                Data.top = Number(top);
            } else {
                Data.top = 0;
            }
        }
    }
    /*
     * t = 1 读   t = 2 写
     */
    public static initTop2(t: number) {
        if(t == 2) {
            egret.localStorage.setItem("top2",String(Data.top2));
        } else {
            var top = egret.localStorage.getItem("top2");
            if(top) {
                Data.top2 = Number(top);
            } else {
                Data.top2 = 0;
            }
        }
    }
    public static sbg;
    public static sboom;
    public static sfail;
    public static stool;
    public static robots = [];//机器人数组
    public static type:number = -1;
    public static pause = false;//是否暂停
    public static score:number = 0;//分数
    public static top: number = 0;//最高分
    public static top2: number = 0;//最高分
    public static mode: number = 1;//游戏模式 1普通 2时间
    public static count: number = 60;//倒计时
    public static gold: number = 0;//金币数
    public static gameing: boolean = false;//是否游戏中
}