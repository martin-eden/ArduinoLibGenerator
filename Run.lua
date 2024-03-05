-- ArduinoLibGenerator external entry point

--[[
  Input

    sequence of strings - command-line arguments

      -+------------------------------------------------------- print help

       +- --print-example ------------------------------------- print example

       +- <ConfigurationFileName> [<ResultsDir>] -------------- compile

       +- --decompile <ConfigurationFileName> [<ResultsDir>] -- decompile

  Output

    Creates files and directories
    Prints to stdout
]]

--[[
  Version: 4
  Last mod.: 2024-03-03
]]

--[[ Load development [workshop]: ] ]
package.path = package.path .. ';../../?.lua'
require('workshop.base')
--]]

--[[ Load built-in [workshop]: ]]
require('Implementation.workshop.base')
--]]

local Implementation = request('Implementation.Interface')

local AddSlashToDirName = request('!.string.file_name.add_dir_postfix')

if is_nil(arg[1]) then
  print(Implementation:GetUsageText())
  return
end

if (arg[1] == '--print-example') then
  io.write(Implementation:GetConfigurationExample())
  return
end

local ConfigurationFilename
local ResultsDir
local DoDecompile

do
  if (arg[1] == '--decompile') then
    ConfigurationFilename = arg[2]
    ResultsDir = arg[3]
    DoDecompile = true
  else
    ConfigurationFilename = arg[1]
    ResultsDir = arg[2]
    DoDecompile = false
  end

  assert_string(ConfigurationFilename)
  if not is_nil(ResultsDir) then
    assert_string(ResultsDir)
    ResultsDir = AddSlashToDirName(ResultsDir)
  end
  assert_boolean(DoDecompile)
end

Implementation.ConfigurationFilename = ConfigurationFilename
if ResultsDir then
  Implementation.ResultsDir = ResultsDir
end
Implementation.DoDecompile = DoDecompile

Implementation:Run()

--[[
  2024-02-19
  2024-02-29
  2024-03-02
  2024-03-03
]]
