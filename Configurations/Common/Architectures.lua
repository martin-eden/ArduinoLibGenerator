-- Return table with list of known architectures

--[[
  Unlike list of [Categories] which is relatively constant and
  documented, list of architectures is more open-ended and not
  documented.

  Below is the list of what I've discovered and used. If in doubt,
  just use <.Any> or provide your own string in config.
]]

-- Last mod.: 2024-02-26

return
  {
    Any = '*',
    Avr = 'avr',
    Esp8266 = 'esp8266',
    Esp32 = 'esp32'
  }
