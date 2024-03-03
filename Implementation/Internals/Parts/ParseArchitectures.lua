-- Parse string with list of architectures

--[[
  See [ParseList] for documentation.
]]

-- Last mod.: 2024-03-03

local ParseList = request('!.string.parse_list')

return
  function(DataStr)
    return ParseList(DataStr, _G.tostring, ',')
  end

--[[
  2024-03-03
]]
