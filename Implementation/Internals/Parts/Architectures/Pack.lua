-- Serialize list of architectures

-- Last mod.: 2024-10-24

local SerializeList = request('!.table.serialize_list')

return
  function(Data)
    return SerializeList(Data, _G.tostring, ',')
  end

--[[
  2024-03-04
]]
