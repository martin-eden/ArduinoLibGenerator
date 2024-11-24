-- Serialize list of dependencies

-- Last mod.: 2024-10-24

local SerializeDependency = request('Dependency.Pack')
local ListOfFunc = request('!.concepts.List.ListOfFunc')
local SerializeList = request('!.concepts.List.ToString')

return
  function(Data)
    local DepsStrList = ListOfFunc(SerializeDependency, Data)
    return SerializeList(DepsStrList, ',')
  end

--[[
  2024-03-04
  2024-10-24
]]
