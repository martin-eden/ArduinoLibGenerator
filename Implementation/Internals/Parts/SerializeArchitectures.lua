-- Serialize list of architectures

--[[
  See [SerializeList] for documentation.
]]

-- Last mod.: 2024-03-04

local SerializeList = request('!.table.serialize_list')

return
  function(Data)
    return SerializeList(Data, _G.tostring, ',')
  end

--[[
  2024-03-04
]]
