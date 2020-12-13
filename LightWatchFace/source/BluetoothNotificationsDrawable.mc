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
            if (deviceSettings.phoneConnected)
            {
                dc.drawBitmap(
                    LayoutConstants.BluetoothPosition.x,
                    LayoutConstants.BluetoothPosition.y,
                    ColourManagement.getBluetoothBitmap());
            }
            if (deviceSettings.notificationCount > 0)
            {
                dc.drawBitmap(
                    LayoutConstants.NotificationsPosition.x,
                    LayoutConstants.NotificationsPosition.y,
                    ColourManagement.getNotificationsBitmap());
            }
        }       
    }
}