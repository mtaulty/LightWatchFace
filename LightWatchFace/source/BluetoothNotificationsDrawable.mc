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
                deviceSettings.phoneConnected,
                dc, 
                LayoutConstants.BluetoothPosition,
                ColourManagement.getBluetoothBitmap());

            self.conditionalDrawBitmap( 
                deviceSettings.notificationCount > 0,
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
}