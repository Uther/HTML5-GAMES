
package{
    import laya.display.Sprite;
    import ui.test.football.View1UI;
	import laya.ui.Label;
	import laya.events.Event;

    public class StartScene extends View1UI
    {
        public function StartScene()
        {
            Laya.timer.once(4000, this, clicked);
        }

        private function clicked():void{
            this.removeSelf()
        }
    }
}