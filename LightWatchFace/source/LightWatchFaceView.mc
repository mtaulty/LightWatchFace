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
    // Load your resources here
    function onLayout(dc) 
    {
        setLayout(Rez.Layouts.WatchFace(dc));
    }
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() 
    {
    }
    // Update the view
    function onUpdate(dc)
     {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() 
    {
    }
    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() 
    {
    }
    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() 
    {
    }
}