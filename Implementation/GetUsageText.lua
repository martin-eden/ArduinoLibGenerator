-- Return string with main help text

--[[
  We are using format string to embed name of default directory for
  result.
]]

local UsageTextFmt =
[[
# ArduinoLibGenerator

Generates "library.properties" file for ArduinoIDE from library
description in Lua file.

Usage

  Generate

    $ lua Run.lua <ConfigurationFileName_Lua> [<ResultsDir>]

  Print help

    $ lua Run.lua

  Print example configuration file

    $ lua Run.lua --print-example

Parameters

  <ConfigurationFileName_Lua>

    ".lua" file which is executed and expected to return table with
    library description.

  <ResultsDir>

    Path to directory where generated "library.properties" file is placed.

    Default: "%s"

-- Martin, 2024-02-16/2024-03-02
]]

return
  function(self)
    local Result = ''

    Result = string.format(UsageTextFmt, self.ResultsDir)

    return Result
  end
