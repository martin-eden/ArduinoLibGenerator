-- Get string with contents of example configuration file

--[[
  We are surrounding contents of file with header and footer.
  To make this function less boring.
]]

-- Last mod.: 2024-02-29

local StringFromFile = request('!.file_system.file.as_string')
local StringToLines = request('!.string.to_lines')
local StringFromLines = request('!.string.from_lines')

return
  function()
    local Result = ''

    local ExampleFileName = 'Configurations/Sample.lua'

    local FileContents = ''

    FileContents = StringFromFile(ExampleFileName)

    local ResultLines = {}

    ResultLines = StringToLines(FileContents)

    table.insert(
      ResultLines,
      1,
      string.format('--[ %s ]--', ExampleFileName)
    )

    table.insert(ResultLines, '--]]')

    Result = StringFromLines(ResultLines)

    return Result
  end
