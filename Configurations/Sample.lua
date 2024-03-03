-- Sample configuration file

--[[
  We use Lua to return configuration table.

  This allows us to use language facilities to
  describe value options as tables, move them to standalone files,
  load and then reference by shorter name.

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
        Description =
          'Episode IV. A NEW HOPE',
        Description_Continued =
          [[It is a period of civil war.]] ..
          [[ Rebel spaceships, striking]] ..
          [[ from a hidden base, have won]] ..
          [[ their first victory against]] ..
          [[ the evil Galactic Empire.]] ..
          [[]],
        MoreInfo_Url =
          'https://url-for-more.info',
      },
    How =
      {
        Architectures = { Architectures.Any },
        Dependencies =
          {
            -- { Name = 'ArduinoJson', VersionExpression = '>=7.0.3' },
          },
      },
    Who =
      { Authors = { Iam }, Maintainers = { Iam } },
  }
