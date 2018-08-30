/**Created by the LayaAirIDE,do not modify.*/
package ui.test.football {
	import laya.ui.*;
	import laya.display.*; 

	public class groundUI extends View {
		public var ani1:FrameAnimation;
		public var ground:View;
		public var play10:Button;
		public var play9:Button;
		public var play8:Button;
		public var play7:Button;
		public var play6:Button;
		public var pillar1:Button;
		public var pillar2:Button;
		public var play5:Button;
		public var play4:Button;
		public var play3:Button;
		public var play2:Button;
		public var play1:Button;
		public var play0:Button;
		public var ball:Image;
		public var gateman:Image;
		public var startman:Image;
		public var board:Image;
		public var countlabel:Label;
		public var goalslabel:Label;
		public var version:Label;
		public var tip:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":0,"x":0,"width":640,"pivotY":0,"pivotX":0,"height":960},"child":[{"type":"View","props":{"y":-392,"x":-1884,"width":2883,"var":"ground","pivotY":0,"pivotX":0,"height":1636},"child":[{"type":"Button","props":{"y":1051,"x":1679,"width":60,"var":"play10","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":606,"x":1901,"width":60,"var":"play9","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":852,"x":1782,"width":60,"var":"play8","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":999,"x":1270,"width":60,"var":"play7","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":812,"x":1559,"width":60,"var":"play6","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":650,"x":766,"width":30,"var":"pillar1","pivotY":15,"pivotX":15,"height":30}},{"type":"Button","props":{"y":393,"x":1221,"width":30,"var":"pillar2","pivotY":15,"pivotX":15,"height":30}},{"type":"Button","props":{"y":641,"x":1639,"width":60,"var":"play5","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":938,"x":974,"width":60,"var":"play4","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":747,"x":1328,"width":60,"var":"play3","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":786,"x":1249,"width":60,"var":"play2","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":830,"x":1169,"width":60,"var":"play1","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Button","props":{"y":515,"x":1182,"width":60,"var":"play0","pivotY":30,"pivotX":30,"labelColors":"red","height":60}},{"type":"Image","props":{"width":2883,"skin":"ball/p2_img.jpg","height":1636}},{"type":"Image","props":{"y":1149,"x":2108,"width":70,"var":"ball","skin":"ball/p2_ball.png","pivotY":35,"pivotX":35,"height":70}},{"type":"Image","props":{"y":556,"x":1901,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":690,"x":1329,"width":81,"skin":"ball/p2_red_man.png","pivotY":90,"pivotX":44,"height":188}},{"type":"Image","props":{"y":779,"x":1171,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":734,"x":1250,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":864,"x":1008,"width":81,"skin":"ball/p2_red_man.png","pivotY":71,"pivotX":72,"height":188}},{"type":"Image","props":{"y":1001,"x":1678,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":950,"x":1268,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":592,"x":1641,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":765,"x":1559,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":461,"x":1180,"width":81,"var":"gateman","skin":"ball/p2_blue_man.png","pivotY":94,"pivotX":40,"height":188}},{"type":"Image","props":{"y":1151,"x":2175,"width":104,"var":"startman","skin":"ball/p2_white_man.png","rotation":0,"pivotY":86,"pivotX":52,"height":172}},{"type":"Image","props":{"y":801,"x":1782,"width":81,"skin":"ball/p2_red_man.png","pivotY":94,"pivotX":40,"height":188}}]},{"type":"Image","props":{"width":300,"var":"board","skin":"ball/p2_time.png","height":103,"centerX":0,"bottom":-200},"child":[{"type":"Label","props":{"width":55,"var":"countlabel","valign":"middle","text":"60","height":34,"fontSize":35,"color":"white","centerX":-83,"bottom":5,"bold":true,"align":"center"}},{"type":"Label","props":{"width":55,"var":"goalslabel","valign":"middle","text":"1-0","height":34,"fontSize":35,"color":"white","centerX":89,"bottom":5,"bold":true,"align":"center"}}]},{"type":"Label","props":{"width":150,"var":"version","text":"0.2.2","right":10,"height":40,"fontSize":40,"color":"white","bottom":10,"bold":true,"align":"center"},"compId":61},{"type":"Label","props":{"y":751.8,"x":210.2,"var":"tip","text":"点我开球 >","fontSize":30,"color":"white"},"compId":64}],"animations":[{"nodes":[{"target":64,"keyframes":{"y":[{"value":750,"tweenMethod":"linearNone","tween":true,"target":64,"key":"y","index":0},{"value":753,"tweenMethod":"linearNone","tween":true,"target":64,"key":"y","index":10}],"x":[{"value":230,"tweenMethod":"linearNone","tween":true,"target":64,"key":"x","index":0},{"value":203,"tweenMethod":"linearNone","tween":true,"target":64,"key":"x","index":5},{"value":239,"tweenMethod":"linearNone","tween":true,"target":64,"key":"x","index":10}]}},{"target":61,"keyframes":{"text":[{"value":"0.1.11","tweenMethod":"linearNone","tween":false,"target":61,"key":"text","index":0}]}}],"name":"ani1","id":1,"frameRate":20,"action":2}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}