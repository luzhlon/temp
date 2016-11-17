module LedOnC
{
    uses interface Boot;
    uses interface Leds;
}
implementation
{
    task void DoLedOn()
    {
        call Leds.led0On();
    }
    event void Boot.booted()
    {
        post DoLedOn();
    }
}
