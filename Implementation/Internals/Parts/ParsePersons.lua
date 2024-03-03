-- Parse string with list of persons

--[[
  See [ParseList] and [ParsePerson] for documentation.
]]

-- Last mod.: 2024-03-04

local ParseList = request('!.string.parse_list')
local ParsePerson = request('Core.ParsePerson')

return
  function(DataStr)
    return ParseList(DataStr, ParsePerson, ', ')
  end

--[[
  2024-03-03
  2024-03-04
]]
