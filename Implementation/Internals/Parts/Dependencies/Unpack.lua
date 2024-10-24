-- Parse string with list of dependencies

--[[
  See [ParseList] and [ParseDependency] for documentation.
]]

-- Last mod.: 2024-10-24

local ParseList = request('!.string.parse_list')
local ParseDependency = request('Dependency.Unpack')

return
  function(DataStr)
    return ParseList(DataStr, ParseDependency, ',')
  end

--[[
  2024-03-03
]]
