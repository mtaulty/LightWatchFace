class WrapAroundCounter
{
    function initialize(maxValue, tickValue)
    {
        self.value = 0;
        self.ticks = 0;
        self.tickValue = tickValue;
        self.maxValue = maxValue;
    }
    function increment()
    {
        self.ticks++;
        
        if (self.ticks == self.tickValue)
        {
            self.ticks = 0;
            self.value++;
            self.constrain();
        }
    }
    private function constrain()
    {
        if (self.value < 0)
        {
            self.value = self.maxValue - 1;
        }
        if (self.value >= self.maxValue)
        {
            self.value = 0;
        }
    } 
    function setValue(value)
    {
        self.value = value;
        self.ticks = 0;
        self.constrain();
    }
    function getValue()
    {
        return(self.value);
    }
    private var value;
    private var tickValue;
    private var ticks;
    private var maxValue;
}