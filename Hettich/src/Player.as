
package{
    import laya.display.Sprite;
    import laya.ui.Image;

    public class Player
    {
        public var x:int = 0;
        public var y:int = 0;
        public var width:int = 0;
        public var height:int = 0;
        public var obj:Image;
        public function Player(res:Image)
        {
            this.obj = res;
			this.x = res.x;
			this.y = res.y;
			this.width = res.width;
			this.height = res.height
        }
    }
}