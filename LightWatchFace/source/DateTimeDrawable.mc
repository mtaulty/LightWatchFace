using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DateTimeDrawable extends WatchUi.Drawable {

    function initialize() 
    {
        var dictionary = 
        {
            :identifier => "DateTime"
        };

        self.timeFont = WatchUi.loadResource(Rez.Fonts.helmut);
        self.boldTimeFont = WatchUi.loadResource(Rez.Fonts.helmetBold);

        Drawable.initialize(dictionary);
    }

    function draw(dc) 
    {
        dc.setColor(Graphics.COLOR_TRANSPARENT, ColourManagement.getBackgroundColour());
        dc.clear();
        
        dc.setColor(ColourManagement.getTimeColour(), Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(
            LayoutConstants.TimePosition.x, 
            LayoutConstants.TimePosition.y, 
            self.getTimeFont(),  
            self.getTimeAsString(), 
            Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(ColourManagement.getDateColour(), Graphics.COLOR_TRANSPARENT);
                    
        dc.drawText(
            LayoutConstants.DatePosition.x, 
            LayoutConstants.DatePosition.y, 
            Graphics.FONT_SYSTEM_MEDIUM,  
            self.getDateAsString(), 
            Graphics.TEXT_JUSTIFY_CENTER);
    }
    function getTimeAsString()
    {
        var clockTime = System.getClockTime();

        var hours = clockTime.hour;

        if ((hours > 12) && !System.getDeviceSettings().is24Hour) 
        {
            hours -= 12;
        } 

        var timeString = Lang.format(
            timeFormat, 
            [hours.format(self.getHourFormatString()), clockTime.min.format(mmFormat)]
        );

        return(timeString);
    }
    function getHourFormatString()
    {
        return(System.getDeviceSettings().is24Hour ? hhFormat24 : hhFormat);
    }
    function getDateAsString()
    {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);

        var dateString = Lang.format(
            dateFormat,
            [
                today.day_of_week,
                today.day,
                today.month
            ]
        );
        return(dateString);
    }
    function getTimeFont()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.BoldTimeFont) ? self.boldTimeFont : self.timeFont);
    }
    var timeFont;
    var boldTimeFont;
    const timeFormat = "$1$:$2$";
    const dateFormat = "$1$ $2$ $3$";
    const hhFormat24 = "%02d";
    const hhFormat = "%d";
    const mmFormat = "%02d";
}