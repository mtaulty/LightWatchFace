class WrapAroundCounter
{
    function initialize(maxValue)
    {
        self.maxValue = maxValue;
    }
    function increment()
    {
        self.value++;

        if (self.value >= self.maxValue)
        {
            self.value = 0;
        }
    }
    function decrement()
    {
        self.value--;
        
        if (self.value < 0)
        {
            self.value = self.maxValue - 1;
        }
    }
    var value;
    private var maxValue;
}