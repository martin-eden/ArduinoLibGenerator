-- Return string with main help text

--[[
  We are using format string to embed name of default directory for
  result.
]]

-- Last mod.: 2024-03-03

local UsageTextFmt =
[[
# ArduinoLibGenerator

Generates "library.properties" file for ArduinoIDE from library
description in Lua file.

Usage

  Print help

    $ lua Run.lua

  Print example configuration file

    $ lua Run.lua --print-example

  Compile

    $ lua Run.lua <ConfigurationFileName> [<ResultsDir>]

  Decompile

    $ lua Run.lua --decompile <ConfigurationFileName> [<ResultsDir>]

Parameters

  <ConfigurationFileName>

    When compiling, it's ".lua" file which is executed and expected to
    return table with library description.

    When decompiling, it's ".properties" text file which is expected to
    contain library description.

  <ResultsDir>

    Path to directory where generated file is placed.

    Default: "%s"

-- Martin, 2024-02-16/2024-03-03
]]

return
  function(self)
    local Result = ''

    Result = string.format(UsageTextFmt, self.ResultsDir)

    return Result
  end

--[[
  2024-03-01
  2024-03-03
]]
