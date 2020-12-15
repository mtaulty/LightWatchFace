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
        if (IsDisplayed())
        {
            dc.drawBitmap(
                LayoutConstants.HeartPosition.x,
                LayoutConstants.HeartPosition.y,
                ColourManagement.getHeartBitmap());

            dc.setColor(ColourManagement.getHeartRateColour(), Graphics.COLOR_TRANSPARENT);
            
            dc.drawText(
                LayoutConstants.HeartRatePosition.x, 
                LayoutConstants.HeartRatePosition.y, 
                Graphics.FONT_NUMBER_MILD,  
                self.getHeartRateString(), 
                Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
    function getHeartRateString() 
    {
        var heartRateString = "-";
        
        var info = Activity.getActivityInfo();

        if (info != null)
        {
            var heartRate = info.currentHeartRate;

            if (heartRate != null) 
            {
                heartRateString = heartRate.toString();
            } 
            else 
            {
                var topHistory = ActivityMonitor.getHeartRateHistory(1, true);

                if (topHistory != null)
                {
                    var historySample = topHistory.next().heartRate;

                    if ((historySample != null) && (historySample != ActivityMonitor.INVALID_HR_SAMPLE))
                    {
                        heartRateString = historySample.toString();
                    }
                }
            }
        }
        return(heartRateString);
    }
    static function IsDisplayed()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.DisplayHeartRate));
    }
}