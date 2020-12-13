using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BatteryDrawable extends WatchUi.Drawable {

    function initialize() 
    {
        var dictionary = {
            :identifier => "Battery"
        };

        Drawable.initialize(dictionary);

        for (var i = 0; i < self.resourceIds.size(); i++)
        {
            self.images[i] = WatchUi.loadResource(self.resourceIds[i]); 
        }
    }
    function draw(dc) 
    {
        var image = null;
        var batteryLevel = System.getSystemStats().battery;

        for (var i = 0; i < self.batteryThresholds.size(); i++)
        {
            image = self.images[i];

            if (batteryLevel > self.batteryThresholds[i])
            {
                break;
            }
        }
        dc.drawBitmap(
            LayoutConstants.BatteryPosition.x, 
            LayoutConstants.BatteryPosition.y, 
            image);
    }
    var resourceIds = 
        [ 
            Rez.Drawables.bmpBatteryGood, 
            Rez.Drawables.bmpBatteryOK, 
            Rez.Drawables.bmpBatteryPoor, 
            Rez.Drawables.bmpBatteryDying 
        ];
    var batteryThresholds =
        [
            50,
            20,
            5,
            0
        ];
    var images = new[4];
}