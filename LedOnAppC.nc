configuration LedOnAppC
{
}
implementation
{
    components MainC, LedOnC, LedsC;

    MainC.Boot <- LedOnC.Boot;
    LedOnC.Leds -> LedsC.Leds;
}

