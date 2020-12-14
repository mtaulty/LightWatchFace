using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class LightWatchFaceView extends WatchUi.WatchFace
 {
    function initialize() 
    {
        WatchFace.initialize();
    }
    function onLayout(dc) 
    {
        setLayout(Rez.Layouts.WatchFace(dc));
    }
    function onShow() 
    {
    }
    function onUpdate(dc)
     {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    function onHide() 
    {
    }
    function onExitSleep() 
    {
        var caloriesDrawable = self.findDrawableById(CaloriesStepsDistanceDrawable.ID);
        if (caloriesDrawable != null)
        {
            caloriesDrawable.onExitSleep();
        }
    }
    function onEnterSleep() 
    {
        var caloriesDrawable = self.findDrawableById(CaloriesStepsDistanceDrawable.ID);
        if (caloriesDrawable != null)
        {
            caloriesDrawable.onEnterSleep();
        }
    }
    function onSettingsChanged()
    {
        var batteryDrawable = self.findDrawableById(BatteryDrawable.ID);
        if (batteryDrawable != null)
        {
            batteryDrawable.onSettingsChanged();
        }
    }
}