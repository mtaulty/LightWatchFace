using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BluetoothNotificationsDrawable extends WatchUi.Drawable {

    function initialize() 
    {
        var dictionary = {
            :identifier => "BluetoothNotifications"
        };

        Drawable.initialize(dictionary);
    }
    function draw(dc) 
    {
        var deviceSettings = System.getDeviceSettings();

        if (deviceSettings != null) 
        {
            self.conditionalDrawBitmap(
                (IsBluetoothStatusDisplayed() && deviceSettings.phoneConnected),
                dc, 
                LayoutConstants.BluetoothPosition,
                ColourManagement.getBluetoothBitmap());

            self.conditionalDrawBitmap( 
                (IsNotificationCountDisplayed() && (deviceSettings.notificationCount > 0)),
                dc,
                LayoutConstants.NotificationsPosition,
                ColourManagement.getNotificationsBitmap());
        }       
    }
    function conditionalDrawBitmap(condition, dc, position, bitmap)
    {
        if (condition)
        {
            dc.drawBitmap(position.x, position.y, bitmap);
        }
    }
    static function IsNotificationCountDisplayed()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.DisplayNotifications));
    }
    static function IsBluetoothStatusDisplayed()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.DisplayBluetoothStatus));
    }
}