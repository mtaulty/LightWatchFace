using Toybox;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;

class ColourManagement
{
    static function getCaloriesStepsDistanceColour()
    {
        return(getTimeColour());
    }
    static function getStepGoalColour()
    {
        return(Graphics.COLOR_DK_GREEN);
    }
    static function getBackgroundColor()
    {
        return(IsLightTheme() ? Graphics.COLOR_WHITE : Graphics.COLOR_BLACK);  
    }
    static function getTimeColour()
    {
        return(IsLightTheme() ? Graphics.COLOR_BLACK : Graphics.COLOR_WHITE);     
    }
    static function getDateColour()
    {
        return(Graphics.COLOR_DK_GREEN);
    }
    private static function IsLightTheme()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.LightTheme));
    }
    static function getHeartBitmap()
    {
        return(getBitmapById(Rez.Drawables.bmpHeart));
    }
    static function getBluetoothBitmap()
    {
        return(getBitmapById(Rez.Drawables.bmpBluetooth));
    }
    static function getNotificationsBitmap()
    {
        return(getBitmapById(Rez.Drawables.bmpNotifications));
    }
    static function getCaloriesBitmap()
    {
        return(getBitmapById(Rez.Drawables.bmpCalories));
    }
    static function getStepsBitmap(goalHit)
    {
        var id = goalHit ? Rez.Drawables.bmpStepsGoal : Rez.Drawables.bmpSteps;

        return(getBitmapById(id));
    }
    static function getDistanceBitmap()
    {
        return(getBitmapById(Rez.Drawables.bmpDistance));
    }
    private static function getBitmapById(bitmapId)
    {
        // Change to the light theme bitmap if necessary.
        if (IsLightTheme())
        {
            bitmapId = regularLightBitmapLookup[bitmapId];
        }
        if (bitmapLookup[bitmapId] == null)
        {
            bitmapLookup[bitmapId] = WatchUi.loadResource(bitmapId);
        }
        return(bitmapLookup[bitmapId]);
    }
    private static var bitmapLookup = {};

    private static var regularLightBitmapLookup =
    {
        Rez.Drawables.bmpHeart          => Rez.Drawables.bmpHeartLight,
        Rez.Drawables.bmpNotifications  => Rez.Drawables.bmpNotificationsLight,
        Rez.Drawables.bmpBluetooth      => Rez.Drawables.bmpBluetoothLight,
        Rez.Drawables.bmpSteps          => Rez.Drawables.bmpStepsLight,
        Rez.Drawables.bmpCalories       => Rez.Drawables.bmpCaloriesLight,
        Rez.Drawables.bmpDistance       => Rez.Drawables.bmpDistanceLight,
        Rez.Drawables.bmpStepsGoal      => Rez.Drawables.bmpStepsGoal
    };
}