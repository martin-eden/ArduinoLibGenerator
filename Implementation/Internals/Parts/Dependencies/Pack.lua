-- Serialize list of dependencies

-- Last mod.: 2024-10-24

local SerializeDependency = request('Dependency.Pack')
local FuncToList = request('!.concepts.List.ApplyFunction')
local SerializeList = request('!.concepts.List.ToString')

return
  function(Data)
    local DepsStrList = FuncToList(SerializeDependency, Data)
    return SerializeList(DepsStrList, ',')
  end

--[[
  2024-03-04
  2024-10-24
]]
