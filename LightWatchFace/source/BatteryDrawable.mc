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
            :identifier => ID
        };

        Drawable.initialize(dictionary);

        for (var i = 0; i < self.resourceIds.size(); i++)
        {
            self.images[i] = WatchUi.loadResource(self.resourceIds[i]); 
        }

        self.onSettingsChanged();
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
    function onSettingsChanged()
    {
        for (var i = 0; i < self.batteryThresholdPropertyKeys.size(); i++)
        {
            var value = LightWatchFaceApp.getProperty(self.batteryThresholdPropertyKeys[i]);

            if (value != null)
            {
                self.batteryThresholds[i] = value;
            }
        }
    }
    static var ID = "Battery";

    private var resourceIds = 
        [ 
            Rez.Drawables.bmpBatteryGood, 
            Rez.Drawables.bmpBatteryOK, 
            Rez.Drawables.bmpBatteryPoor, 
            Rez.Drawables.bmpBatteryDying 
        ];
    private var batteryThresholds =
        [
            50,
            20,
            5,
            0
        ];
    private var batteryThresholdPropertyKeys = 
        [
            PropertyConstants.HighBatteryThreshold,
            PropertyConstants.MediumBatteryThreshold,
            PropertyConstants.LowBatteryThreshold
        ];
    private var images = new[4];
    
}