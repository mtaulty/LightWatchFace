using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class HeartRateDrawable extends WatchUi.Drawable 
{
    function initialize() 
    {
        var dictionary = 
        {
            :identifier => "HeartRate"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc)
    {
        dc.drawBitmap(
            LayoutConstants.HeartPosition.x,
            LayoutConstants.HeartPosition.y,
            ColourManagement.getHeartBitmap());

        dc.setColor(ColourManagement.getBackgroundColor(), Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(
            LayoutConstants.HeartRatePosition.x, 
            LayoutConstants.HeartRatePosition.y, 
            Graphics.FONT_NUMBER_MILD,  
            self.getHeartRateString(), 
            Graphics.TEXT_JUSTIFY_CENTER);
    }
    function getHeartRateString() 
    {
        var heartRateString = "-";
        
        var heartRate = Activity.getActivityInfo().currentHeartRate;

        if (heartRate != null) 
        {
            heartRateString = heartRate.toString();
        } 
        else 
        {
            var topHistory = ActivityMonitor.getHeartRateHistory(1, true);

            var historySample = topHistory.next().heartRate;

            if ((historySample != null) && (historySample != ActivityMonitor.INVALID_HR_SAMPLE))
            {
                 heartRateString = historySample.toString();
            }
        }
        return(heartRateString);
    }
}