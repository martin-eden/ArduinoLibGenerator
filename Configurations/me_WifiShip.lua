-- Configuration data for ArduinoLibGenerator

--[[
  Status: designing
  Version: 1
  Last mod.: 2024-02-11
]]

--[[
  Originally I wanted to use some data format like JSON.

  But requirement to quote key names and forbidden tail delimiters
  were too much for my taste of style. JSON5 is good. But I haven't
  written parser for it yet.

  So I decided to keep configs as Lua code.

    Lua code returning Lua table of course is overkill.

    It's security hole if you have no control over this file contents.

    But come on man, I'm doing this stuff for personal fun,
    not for someone who want to use this code for making money.

    Also I like ability to have several references to table.

    And I like data modelling.

  Similar thing in design intention is Makefiles. But there is
  ${syncrasy} and I have feeling I'm in US 1970s.
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
    Name = 'me_WifiShip',
    Version = '1.0.0',
    Category = Categories.Communication,
    Description = 'Scan WiFi and connect to station.',
    Description_Continued =
      [[Simple API for daily tasks: ]] ..
      [[get/set own name and MAC, scan network, connect to router, return IP. ]] ..
      [[I've used space terminology "dock/undock", "ship" and "station" ]] ..
      [[for coding delight. ]] ..
      [[Implemented as a wrapper over "ESP8266WiFi.h".]] ..
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
    ReadOnly = false,
    Architectures = { Architectures.Esp8266 },
    Dependecies =
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
