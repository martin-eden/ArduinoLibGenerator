-- Return dictionary of known architectures known by ArduinoIDE

--[[
  Unlike list of [Categories] which is relatively constant and
  documented, list of architectures is open-ended and not documented.

  Below is the list of what I've discovered and used. If in doubt,
  just <Any> or provide your own string in config or add name here.
]]

-- Last mod.: 2024-03-03

return
  {
    Any = '*',

    Avr = 'avr',
    Esp8266 = 'esp8266',
    Esp32 = 'esp32'
  }
