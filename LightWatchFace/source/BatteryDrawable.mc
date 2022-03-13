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

        self.drawMethods =
        [
            self.method(:drawBatteryIcon),
            self.method(:drawBatteryText)
        ];
        self.tickCount = new WrapAroundCounter(self.drawMethods.size(), CALLS_BETWEEN_TICKS);

        self.onSettingsChanged();
    }
    function draw(dc) 
    {
        var batteryLevel = System.getSystemStats().battery;

         var drawMethod = self.drawMethods[0];

         if (self.highPower)
         {
            drawMethod = self.drawMethods[self.tickCount.getValue()];
            self.tickCount.increment();
         }
         drawMethod.invoke(dc, batteryLevel);
    }
    function getBatteryLevelIndex(batteryLevel)
    {
        var index = 0;

        for (var i = 0; i < self.batteryThresholds.size(); i++)
        {
            if (batteryLevel > self.batteryThresholds[i])
            {
                index = i;
                break;
            }
        }      
        return(index);  
    }
    function drawBatteryIcon(dc, batteryLevel)
    {
        var image = self.images[getBatteryLevelIndex(batteryLevel)];

        dc.drawBitmap(
            LayoutConstants.BatteryPosition.x, 
            LayoutConstants.BatteryPosition.y, 
            image);
    }
    function drawBatteryText(dc, batteryLevel)
    {
        var color = self.batteryColors[getBatteryLevelIndex(batteryLevel)];

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(
            LayoutConstants.BatteryTextPosition.x, 
            LayoutConstants.BatteryTextPosition.y, 
            Graphics.FONT_SYSTEM_MEDIUM,  
            batteryLevel.format(BATTERY_TEXT_FORMAT) + BATTERY_PERCENT, 
            Graphics.TEXT_JUSTIFY_CENTER);

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
    function onEnterSleep()
    {
        self.highPower = false;
    }
    function onExitSleep()
    {
        self.highPower = true;
        self.tickCount.setValue(0);
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
    private var batteryColors =
        [
            Graphics.COLOR_GREEN,
            Graphics.COLOR_YELLOW,
            Graphics.COLOR_RED,
            Graphics.COLOR_DK_RED
        ];
    private var tickCount;
    private var images = new[4];
    private var highPower = true;
    private var drawMethods;
    private const CALLS_BETWEEN_TICKS = 2;
    private const BATTERY_PERCENT = "%";
    private const BATTERY_TEXT_FORMAT = "%d";
}