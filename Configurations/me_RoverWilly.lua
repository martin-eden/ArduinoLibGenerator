-- Configuration data for me_RoverWilly library

--[[
  Version: 1
  Last mod.: 2024-02-26
]]

local Categories = request('Configurations.Common.Categories')
local Architectures = request('Configurations.Common.Architectures')

local Iam =
  {
    Name = 'Martin Eden',
    Email = '',
  }

return
  {
    What =
      {
        Name = 'me_RoverWilly',
        Version = '1.0.0',
        Category = Categories.DeviceControl,
        Description = 'Firmware for "Willy" rover. Esplora.',
        Description_Continued = '',
        MoreInfo_Url = 'https://github.com/martin-eden/willy',
      },
    How =
      {
        ReadOnly = true,
        Architectures = { Architectures.Esp8266 },
        Dependencies =
          {
            { Name = 'Adafruit MPU6050', VersionExpression = '>=2.2.4' },
            { Name = 'ArduinoJson', VersionExpression = '>=7.0.3' },
          },
      },
    Who =
      {
        Authors = { Iam },
        Maintainers = { Iam },
      }
  }
