-- ArduinoLibGenerator external entry point

--[[
  Version: 3
  Last mod.: 2024-02-29
]]

package.path = package.path .. ';../../workshop/?.lua'
require('base')

local Implementation = request('Implementation.Interface')

if is_nil(arg[1]) then
  print(Implementation:GetUsageText())
  return
end

if (arg[1] == '--print-example') then
  io.write(Implementation:GetConfigurationExample())
  return
end

-- Command-line arguments (
local ConfigurationFilename = arg[1]
local ResultsDir = arg[2]
-- )

assert_string(ConfigurationFilename)
Implementation.ConfigurationFilename = ConfigurationFilename

if is_string(ResultsDir) then
  Implementation.ResultsDir = ResultsDir
end

Implementation:Run()

--[[
  2024-02-19
  2024-02-29
]]
