using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

class CaloriesStepsDistanceDrawable extends WatchUi.Drawable 
{
    function initialize() 
    {
        var dictionary = 
        {
            :identifier => ID
        };

        self.drawMethods =
        [
            self.method(:drawSteps),
            self.method(:drawDistance),
            self.method(:drawCalories),            
        ];
        self.tickCount = new WrapAroundCounter(self.drawMethods.size(), CALLS_BETWEEN_TICKS);

        Drawable.initialize(dictionary);
    }
    function draw(dc) 
    {
        if (IsDisplayed())
        {
            var drawMethod = self.drawMethods[0];

            if (IsDisplayingAll())
            {
                if (self.highPower)
                {
                    drawMethod = self.drawMethods[self.tickCount.getValue()];
                    self.tickCount.increment();
                }
            }
            else
            {
                drawMethod = self.drawMethods[GetDisplayType()];
            }         
            drawMethod.invoke(dc, ActivityMonitor.getInfo());
        }
    }
    function onEnterSleep()
    {
        self.highPower = false;
    }
    function onExitSleep()
    {
        self.highPower = true;        
        self.tickCount.setValue(0);
    }
    // It seems that if these next 3 methods aren't public (I'd like then to be private)
    // then I can't use Method.invoke() to invoke them. So, they are public
    function drawSteps(dc, info)
    {
        // Steps and stepgoal are number of steps for the day.
        var hitGoal = info.steps >= info.stepGoal;
        var colour = hitGoal ? ColourManagement.getStepGoalColour() : 
            ColourManagement.getCaloriesStepsDistanceColour();

        self.drawValue(
            dc, 
            info.steps.format(STEPS_FORMAT_STRING), 
            colour, 
            ColourManagement.getStepsBitmap(hitGoal));
    }
    function drawDistance(dc, info)
    {
        // Distance is reported in cm for the day.
        var distanceKms = info.distance / 100000.0;
        var distanceMiles = info.distance / KM_TO_MILES;
        var metric = System.getDeviceSettings().distanceUnits == System.UNIT_METRIC;
        var distance = 
            metric ? 
                distanceKms.format(DISTANCE_FORMAT_STRING) : 
                distanceMiles.format(DISTANCE_FORMAT_STRING);

        distance += metric ? KMS : MILES;

        self.drawValue(
            dc, 
            distance,
            ColourManagement.getCaloriesStepsDistanceColour(), 
            ColourManagement.getDistanceBitmap());
    }
    function drawCalories(dc, info)
    {
        var calories = info.calories.format(CALORIES_FORMAT_STRING) + KCAL;

        // Calories are reported in kCal for the day.
        self.drawValue(
            dc, 
            calories,
            ColourManagement.getCaloriesStepsDistanceColour(), 
            ColourManagement.getCaloriesBitmap());
    }
    private function drawValue(dc, value, colour, bitmap)
    {
        dc.setColor(colour, Graphics.COLOR_TRANSPARENT);

        var textSize = dc.getTextDimensions(value, Graphics.FONT_SYSTEM_TINY);
        var textWidth = textSize[0];
        var textHeight = textSize[1];
        var rightEnd = LayoutConstants.StepsCaloriesDistancePosition.x + (textWidth / 2);        

        dc.drawText(
            LayoutConstants.StepsCaloriesDistancePosition.x, 
            LayoutConstants.StepsCaloriesDistancePosition.y, 
            Graphics.FONT_SYSTEM_SMALL,  
            value, 
            Graphics.TEXT_JUSTIFY_CENTER);   

        dc.drawBitmap(
            rightEnd,
            LayoutConstants.StepsCaloriesDistancePosition.y,
            bitmap);
    }
    private static function GetDisplayType()
    {
        return(LightWatchFaceApp.getProperty(PropertyConstants.MetricsDisplay));
    }
    private static function IsDisplayed()
    {
        return(GetDisplayType() != DISPLAY_TYPE_NONE); 
    }
    private static function IsDisplayingAll()
    {
        return(GetDisplayType() == DISPLAY_TYPE_ALL);
    }
    private var drawMethods;
    private var highPower = true;
    private var tickCount;
    static var ID = "CaloriesStepsDistance";
    private const CALLS_BETWEEN_TICKS = 2;
    private const KM_TO_MILES = 160934.0;
    private const DISTANCE_FORMAT_STRING = "%01.2f";
    private const CALORIES_FORMAT_STRING = "%d";
    private const STEPS_FORMAT_STRING = "%d";
    private const MILES = " mi";
    private const KMS = " km";
    private const KCAL = " kCal";
    private const DISPLAY_TYPE_NONE = 4;
    private const DISPLAY_TYPE_ALL = 3;
}