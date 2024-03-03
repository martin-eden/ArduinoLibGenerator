-- Parse string with list of dependencies

--[[
  See [ParseList] and [ParseDependency] for documentation.
]]

-- Last mod.: 2024-03-03

local ParseList = request('!.string.parse_list')
local ParseDependency = request('Core.ParseDependency')

return
  function(DataStr)
    return ParseList(DataStr, ParseDependency, ', ')
  end

--[[
  2024-03-03
]]
