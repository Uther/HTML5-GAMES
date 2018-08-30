
package{
    import laya.display.Sprite;
    import ui.test.football.goalUI;
	import laya.ui.Label;
	import laya.events.Event;

    public class Goal extends goalUI
    {
        public function Goal()
        {
            Laya.timer.once(2000, this, clicked);
        }

        private function clicked():void{
            this.removeSelf()
        }
    }
}