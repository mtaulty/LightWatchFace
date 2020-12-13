using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

class CaloriesStepsDistanceDrawable extends WatchUi.Drawable {

    function initialize() 
    {
        var dictionary = 
        {
            :identifier => ID
        };
        Drawable.initialize(dictionary);
    }

    function draw(dc) 
    {
        if (self.highPower)
        {
            self.tickCount++;

            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

            dc.drawText(
                104, 
                160, 
                Graphics.FONT_SYSTEM_TINY,  
                self.tickCount.toString(), 
                Graphics.TEXT_JUSTIFY_CENTER);
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
    var highPower = true;
    var tickCount = 0;
    static var ID = "CaloriesStepDistance";
}