-- Serialize list of dependencies

--[[
  See [SerializeList] and [SerializeDependency] for documentation.
]]

-- Last mod.: 2024-03-04

local SerializeList = request('!.table.serialize_list')
local SerializeDependency = request('Dependency.Pack')

return
  function(Data)
    return SerializeList(Data, SerializeDependency, ', ')
  end

--[[
  2024-03-04
]]
