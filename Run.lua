-- ArduinoLibGenerator external entry point

--[[
  Input

    sequence of strings - command-line arguments

      Only one parameter is required - <ConfigurationFileName>
      Second one is optional - <ResultsDir>

      if (arg[1] == nil)
        print help
      if (arg[1] == "--print-example")
        print example configuration
      else
        ConfigurationFileName = arg[1]
        if (arg[2] == nil)
          ResultsDir = Defaults.ResultsDir
        else
          ResultsDir = arg[2]

  Output

    Creates files and directories
    Prints to stdout
]]

--[[
  Version: 3
  Last mod.: 2024-03-02
]]

-- package.path = package.path .. ';../../?.lua'
require('workshop.base')

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
  2024-03-02
]]
