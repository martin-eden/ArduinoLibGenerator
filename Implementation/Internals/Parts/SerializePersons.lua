-- Serialize list of persons

--[[
  See [SerializeList] and [SerializePerson] for documentation.
]]

-- Last mod.: 2024-03-04

local SerializeList = request('!.table.serialize_list')
local SerializePerson = request('Core.SerializePerson')

return
  function(Data)
    return SerializeList(Data, SerializePerson, ', ')
  end

--[[
  2024-03-04
]]
