/**Created by the LayaAirIDE,do not modify.*/
package ui.test.football {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class View1UI extends Dialog {
		public var startCount:Clip;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"y":0,"x":0,"width":640,"height":960},"child":[{"type":"Image","props":{"y":0,"x":0,"width":640,"skin":"ball/blank.png","height":960}},{"type":"Clip","props":{"y":50,"x":73,"var":"\bstartCount","skin":"ball/p2_nub.png","interval":1000,"index":4,"clipY":5,"centerX":0,"autoPlay":true}},{"type":"Image","props":{"y":300,"x":227,"width":187,"skin":"ball/p2_phone.png","height":246,"centerX":0}},{"type":"Text","props":{"y":550,"x":0,"width":640,"text":"晃动手机 ","height":57,"fontSize":40,"color":"white","align":"center"}},{"type":"Text","props":{"y":600,"x":0,"width":640,"text":"助力德国队攻破球门","height":40,"fontSize":40,"color":"white","align":"center"}}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}