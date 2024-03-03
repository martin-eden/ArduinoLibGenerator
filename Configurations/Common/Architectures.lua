-- Return dictionary of known architectures known by ArduinoIDE

--[[
  Unlike list of [Categories] which is relatively constant and
  documented, list of architectures is open-ended and not documented.

  Below in this comment is the list of architectures I've discovered.
  Returned table is architectures that I've actually used. I don't
  want to create names for things that I don't use.

  Discovered architectures:

    avr
    esp8266
    esp32
    mbed
    mbed_nano
    mbed_portenta
    mbed_rp2040
    megaavr
    nrf52
    renesas
    renesas_portenta
    renesas_uno
    sam
    samd
    stm32f4
]]

-- Last mod.: 2024-03-04

return
  {
    Any = '*',

    Avr = 'avr',
    Esp8266 = 'esp8266',
    Esp32 = 'esp32'
  }

--[[
  2024-02-26
]]
