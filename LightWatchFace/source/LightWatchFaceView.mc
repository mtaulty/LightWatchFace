using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class LightWatchFaceView extends WatchUi.WatchFace
 {
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } 
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        var view = View.findDrawableById("lblTime");
        view.setText(timeString);

        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
         var dateString = Lang.format(
            "$1$ $2$ $3$",
            [
                today.day_of_week,
                today.day,
                today.month
            ]
        );
        view = View.findDrawableById("lblDate");
        view.setText(dateString);

        view = View.findDrawableById("lblHeart");     
        view.setText(getHeartRate());

        // var notificationCount = System.getDeviceSettings().notificationCount;        
        // var phoneConnected = System.getDeviceSettings().phoneConnected;      
        // var stepCount = ActivityMonitor.History.steps;
        // var stepGoal = ActivityMonitor.History.stepGoal;
        // var activeMinutes = ActivityMonitor.History.activeMinutes;

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    function getHeartRate() 
    {
        var ret="--";
        
        var hr = Activity.getActivityInfo().currentHeartRate;

        if (hr != null) 
        {
            ret = hr.toString();
        } 
        else 
        {
            var hrI = ActivityMonitor.getHeartRateHistory(1, true);
            var hrs = hrI.next().heartRate;
            if(hrs != null && hrs != ActivityMonitor.INVALID_HR_SAMPLE)
            {
                 ret = hrs.toString();
            }
        }
        return ret;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
}