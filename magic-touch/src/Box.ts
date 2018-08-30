/**
 * box提示框，带确定取消按钮
 * @jetty
 *
 */
class Box extends eui.Panel {
    private mode1: eui.Button;
    private mode2: eui.Button;
    public constructor() {
        super();
        this.cacheAsBitmap = true;
        this.skinName = skins.box.BoxSkin;
    }

    public createChildren(): void {
        super.createChildren();
        this.mode1['title'].text = "普通模式";
        this.mode2['title'].text = "计时模式";
        this.mode1.addEventListener(egret.TouchEvent.TOUCH_TAP,this._mode1,this);
        this.mode2.addEventListener(egret.TouchEvent.TOUCH_TAP,this._mode2,this);
    }
    
    private _mode1() { 
        this.close();
        Data.mode = 1;
        this.dispatchEvent(new egret.Event('mode'));
    }
    private _mode2() {
        this.close();
        Data.mode = 2;
        this.dispatchEvent(new egret.Event('mode'));
    }
}
