using Toybox;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;

class ColourManagement
{
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
        // return(true);
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
    static var bitmapLookup = {};

    static var regularLightBitmapLookup = 
    {
        Rez.Drawables.bmpHeart          => Rez.Drawables.bmpHeartLight,
        Rez.Drawables.bmpNotifications  => Rez.Drawables.bmpNotificationsLight,
        Rez.Drawables.bmpBluetooth      => Rez.Drawables.bmpBluetoothLight
    };
    static var lightThemeHeart;
    static var darkThemeHeart;
}