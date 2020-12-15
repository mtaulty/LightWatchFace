using Toybox;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;

class ColourManagement
{
    static function getBackgroundColour()
    {
        return(getSettableColour(PropertyConstants.BackgroundColour, true));
    }
    static function getTimeColour()
    {
        return(getSettableColour(PropertyConstants.TimeColour, false));
    }
    static function getDateColour()
    {
        return(getSettableColour(PropertyConstants.DateColour, false));
    }
    static function getMetricsColour()
    {
        return(getSettableColour(PropertyConstants.MetricsColour, false));
    }
    static function getHeartRateColour()
    {
        return(getSettableColour(PropertyConstants.HeartRateColour, true));
    }
    private static function getSettableColour(propertyId, isInverse)
    {
        var colour = LightWatchFaceApp.getProperty(propertyId);

        if (colour == PropertyConstants.ThemeColour)
        {
            colour = IsLightTheme() ? Graphics.COLOR_BLACK : Graphics.COLOR_WHITE;

            if (isInverse)
            {
                colour = InvertColour(colour);
            }
        }
        return(colour);
    }
    private static function InvertColour(colour)
    {
        return(colour == Graphics.COLOR_WHITE ? Graphics.COLOR_BLACK : Graphics.COLOR_WHITE);
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
        Rez.Drawables.bmpStepsGoal      => Rez.Drawables.bmpStepsGoal // bit of a hack, same bitmap (green) for both themes
    };
}