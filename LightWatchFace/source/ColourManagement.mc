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
        var setting = LightWatchFaceApp.getProperty(PropertyConstants.HeartColour);
        var bitmap = null;

        if (setting == PropertyConstants.ThemeColour)
        {
            bitmap = getThemedBitmapById(Rez.Drawables.bmpHeart);
        }
        else
        {
            bitmap = lazyLoadBitmap(heartBitmapLookup[setting]);
        }
        return(bitmap);
    }
    static function getBluetoothBitmap()
    {
        return(getThemedBitmapById(Rez.Drawables.bmpBluetooth));
    }
    static function getNotificationsBitmap()
    {
        return(getThemedBitmapById(Rez.Drawables.bmpNotifications));
    }
    static function getCaloriesBitmap()
    {
        return(getThemedBitmapById(Rez.Drawables.bmpCalories));
    }
    static function getStepsBitmap(goalHit)
    {
        var id = goalHit ? Rez.Drawables.bmpStepsGoal : Rez.Drawables.bmpSteps;

        return(getThemedBitmapById(id));
    }
    static function getDistanceBitmap()
    {
        return(getThemedBitmapById(Rez.Drawables.bmpDistance));
    }
    private static function getThemedBitmapById(bitmapId)
    {
        // Change to the light theme bitmap if necessary.
        if (IsLightTheme())
        {
            bitmapId = regularLightBitmapLookup[bitmapId];
        }
        return(lazyLoadBitmap(bitmapId));
    }
    private static function lazyLoadBitmap(bitmapId)
    {
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

    private static var heartBitmapLookup =
    {
        0xFFFFFF    =>  Rez.Drawables.bmpHeart,
        0xAA0000    =>  Rez.Drawables.bmpHeartRed,
        0x00AA00    =>  Rez.Drawables.bmpHeartGreen,
        0x0000AA    =>  Rez.Drawables.bmpHeartBlue,
        0x55FFFF    =>  Rez.Drawables.bmpHeartCyan,
        0xFFFF55    =>  Rez.Drawables.bmpHeartYellow,
        0xFF55FF    =>  Rez.Drawables.bmpHeartMagenta,
        0x000000    =>  Rez.Drawables.bmpHeartLight
    };
}