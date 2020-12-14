using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

class CaloriesStepsDistanceDrawable extends WatchUi.Drawable 
{
    function initialize() 
    {
        var dictionary = 
        {
            :identifier => ID
        };

        // self.drawMethods =
        // [
        //     method(:drawSteps),
        //     method(:drawCalories),
        //     method(:drawDistance)
        // ];
        Drawable.initialize(dictionary);
    }
    function draw(dc) 
    {
        var drawMethod = self.drawMethods[0];

        if (self.highPower)
        {
            self.tickCount.increment();

            // drawMethod = self.drawMethods[self.tickCount.value];

            // dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

            // dc.drawText(
            //     104, 
            //     160, 
            //     Graphics.FONT_SYSTEM_TINY,  
            //     self.tickCount.toString(), 
            //     Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
    function onEnterSleep()
    {
        self.highPower = false;
    }
    function onExitSleep()
    {
        self.highPower = true;
        self.tickCount = 0;
    }
    private function drawSteps(dc)
    {
        System.println("drawSteps");
    }
    private function drawDistance(dc)
    {
        System.println("drawDistance");
    }
    private function drawCalories(dc)
    {
        System.println("drawCalories");
    }
    private var drawMethods;
    private var highPower = true;
    private var tickCount = new WrapAroundCounter(drawMethods.size());
    static var ID = "CaloriesStepDistance";
}