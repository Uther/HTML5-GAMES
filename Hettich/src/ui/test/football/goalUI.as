/**Created by the LayaAirIDE,do not modify.*/
package ui.test.football {
	import laya.ui.*;
	import laya.display.*; 

	public class goalUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":640,"popupCenter":true,"height":960,"alpha":1},"child":[{"type":"Image","props":{"width":361,"skin":"ball/p2_goal.png","height":367,"centerY":0,"centerX":0}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}