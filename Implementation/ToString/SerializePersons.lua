-- Serialize list of persons

local SerializePerson = request('SerializePerson')

return
  function(Persons)
    assert_table(Persons)
    local Results = {}
    for _, Person in ipairs(Persons) do
      table.insert(Results, SerializePerson(Person))
    end
    local Result = table.concat(Results, ", ")
    return Result
  end
