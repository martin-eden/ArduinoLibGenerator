-- ArduinoLibGenerator external entry point

--[[
  Version: 2
  Last mod.: 2024-02-16
]]

package.path = package.path .. ';../../workshop/?.lua'
require('base')

local AddSlashToDirName = request('!.string.file_name.add_dir_postfix')

local DefaultResultsDir = 'Results/'

-- Command-line arguments [
local ConfigurationFileName = arg[1]
local ResultsDir = arg[2] or DefaultResultsDir
ResultsDir = AddSlashToDirName(ResultsDir)
-- ]

local PrintUsage =
  function()
    local UsageTextFmt =
[[
# ArduinoLibGenerator

What

  Generate "library.properties" file from description in Lua table.

Usage

  $ lua Run.lua <ConfigurationFileName_Lua> [<ResultsDir>]

Parameters

  <ConfigurationFileName_Lua> - .lua file which returns table with
    library description.

    Sample configuration

      local IAm = { Name = 'Martin Eden',  Email = '' }

      return
        {
          What =
            {
              Name = 'YourLibbaName',
              Version = '1.0.0', -- Semver
              Category = 'Uncategorized',
              Description = 'First line of description.',
              Description_Continued = 'Second line of description.',
              MoreInfo_Url = 'https://url-for-more.info',
            },
          How =
            {
              ReadOnly = false,
              Architectures = { 'esp8266' },
              Dependencies =
                {
                  { Name = '', VersionExpression = '' },
                },
            },
          Who =
            {
              Authors = { IAm },
              Maintainers = { IAm },
            },
        }

    (Here it is mostly to show supported fields and their types. In
    practice you can (should) use code to generate this table. That's
    the reason why configuration file is Lua code and not JSON.)

  <ResultsDir> - Path to directory where result files are written.
    Default: %s

    We write "library.properties" and maybe ".development" files there.

    You can copy move to directory with your library for ArduinoIDE.

-- Martin, 2024-02-16
]]
    local UsageText = string.format(UsageTextFmt, DefaultResultsDir)
    print(UsageText)
  end

if is_nil(ConfigurationFileName) then
  PrintUsage()
  return
end

local Implementation = request('Implementation.Interface')

Implementation:Run(ConfigurationFileName, ResultsDir)
