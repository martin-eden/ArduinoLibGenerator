-- ArduinoLibGenerator external entry point

--[[
  Status: okay
  Version: 1
  Last mod.: 2024-02-14
]]

package.path = package.path .. ';../../workshop/?.lua'
require('base')

local ConfigurationFileName = arg[1]

local PrintUsage =
  function()
    local UsageText =
[[
## ArduinoLibGenerator

What

  Generate "library.properties" file from description in Lua table.

Usage

  $ lua Run.lua <ConfigurationFileName.lua>

Output

  In case of success it creates "Results/" directory and writes
  "library.properties" and maybe ".development" files there.
  You can copy them to directory with your library for ArduinoIDE.

  You are expected to have Lua 5.3 (5.4 is fine too) installed and
  have enough proficiency to edit .lua file with your library
  description.

-- Martin, 2024-02-14
]]

    print(UsageText)
  end

if is_nil(ConfigurationFileName) then
  PrintUsage()
  return
end

local Implementation = request('Implementation.Interface')

Implementation:Run(ConfigurationFileName)
