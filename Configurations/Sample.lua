-- Sample configuration file

--[[
  We use Lua to return configuration table. This allows us to move
  constant strings to table and reference them by shorter name.

  Also we are using the same person record <Iam> both in list
  of authors and maintainers.
]]

local Categories = require('Configurations.Common.Categories')
local Architectures = require('Configurations.Common.Architectures')

local Iam = { Name = 'John Johnson',  Email = '' }

return
  {
    What =
      {
        Name = 'MyLibbaName',
        Version = '1.0.0', -- Semver
        Category = Categories.Unset,
        Description = 'First line of description.',
        Description_Continued = 'Second line of description.',
        MoreInfo_Url = 'https://url-for-more.info',
      },
    How =
      {
        Architectures = { Architectures.Esp8266 },
        Dependencies =
          {
            -- { Name = 'ArduinoJson', VersionExpression = '>=7.0.3' },
          },
      },
    Who =
      {
        Authors = { Iam },
        Maintainers = { Iam },
      },
  }
