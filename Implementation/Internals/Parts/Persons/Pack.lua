-- Serialize list of persons

--[[
  See [SerializeList] and [SerializePerson] for documentation.
]]

-- Last mod.: 2024-10-24

local SerializePerson = request('Person.Pack')
local ListOfFunc = request('!.concepts.List.ListOfFunc')
local SerializeList = request('!.concepts.List.ToString')

return
  function(Data)
    local PersStrList = ListOfFunc(SerializePerson, Data)
    return SerializeList(PersStrList, ',')
  end

--[[
  2024-03-04
  2024-10-24
]]
