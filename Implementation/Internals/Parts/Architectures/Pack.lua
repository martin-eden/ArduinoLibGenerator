-- Serialize list of architectures

-- Last mod.: 2024-10-24

local SerializeList = request('!.concepts.List.ToString')

return
  function(Data)
    return SerializeList(Data, ',')
  end

--[[
  2024-03-04
]]
