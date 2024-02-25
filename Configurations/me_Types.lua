-- Configuration data for me_Types

--[[
  Version: 1
  Last mod.: 2024-02-20
]]

--
-- What
--
-- Hardcoded categories
local Categories =
  {
    Default = 'Uncategorized',
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

-- List of architectures I've discovered
local Architectures =
  {
    Any = '*',
    Avr = 'avr',
    Esp8266 = 'esp8266',
    Esp32 = 'esp32'
  }

-- # Describe your library:
local What =
  {
    Name = 'me_Types',
    Version = '1.0.0',
    Category = Categories.Other,
    Description = 'Type definitions used in my code.',
    Description_Continued =
      [[TSint_(1, 2, 4), TUint_(1, 2, 4), TChar, TBool, TFloat.]] ..
      [[]],
    MoreInfo_Url = 'https://github.com/martin-eden/arduino_sketchbook/',
  }

--
-- How
--
--[[
  # Set <ReadOnly? to false if you want changeable examples in IDE.

    This will create ".development" flag file and library is indexer
    will ignore it.
  # Check that <Architectures> list is correct.
]]
local How =
  {
    ReadOnly = true,
    Architectures = { Architectures.Avr, Architectures.Esp8266 },
    Dependencies =
      {
        { Name = '', VersionExpression = '' },
      },
  }
-- ^ I'm leaving the fun of parsing version expressions to ArduinoIDE.

--
-- Who
--
local Iam =
  {
    Name = 'Martin Eden',
    Email = '',
  }

--
-- Final result generation
--
local Result =
  {
    What = What,
    How = How,
    Who =
      {
        Authors = { Iam },
        Maintainers = { Iam },
      }
  }

return Result
