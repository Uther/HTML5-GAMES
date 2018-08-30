/**
 * 游戏结束页
 * @jetty
 *
 */
class Over extends eui.Panel {
    private score: eui.Label;
    private again: eui.Button;
    private s;
    public constructor(s) {
        super();
        this.cacheAsBitmap = true;
        this.s = s;
        this.skinName = skins.box.OverSkin;
    }

    public createChildren(): void {
        super.createChildren();
        this.score.text = this.s + "分";
        this.again['title'].text = "再来一次";
        //点击事件监听
        this.again.addEventListener(egret.TouchEvent.TOUCH_TAP,this._again,this);
    }
    
    private _again() { 
        this.close();
        //回调
        this.dispatchEvent(new egret.Event('again'));
    }
}
