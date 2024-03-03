-- Return dictionary of common ArduinoIDE library categories

--[[
  Category names are hardcoded in format specification.
  But you can rename fields for your convenience.
]]

-- Last mod.: 2024-03-02

return
  {
    Unset = 'Uncategorized',
    Other = 'Other',

    SignalIO = 'Signal Input/Output',
    DeviceControl = 'Device Control',
    Timing = 'Timing',
    Sensors = 'Sensors',
    DataProcessing = 'Data Processing',
    DataStorage = 'Data Storage',
    Communication = 'Communication',
    Display = 'Display',
  }

--[[
  2024-02-26
  2024-03-02
]]
