--[[
  For list of categories and version expressions go to

    https://arduino.github.io/arduino-cli/0.35/library-specification/
]]

local Iam = { Name = 'John Johnson',  Email = '' }

return
  {
    What =
      {
        Name = 'MyLibbaName',
        Version = '1.0.0', -- Semver
        Category = 'Uncategorized',
        Description = 'First line of description.',
        Description_Continued = 'Second line of description.',
        MoreInfo_Url = 'https://url-for-more.info',
      },
    How =
      {
        Architectures = { 'esp8266' },
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
