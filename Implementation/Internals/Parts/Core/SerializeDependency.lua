-- Serialize dependency record

--[[
  Input

    table

      {
        Name: string
        VersionExpr: string
      }

  Output

    string

  Special cases

    If <Name> is empty string
      Stop record processing
    If <VersionExpr> is empty string
      Stop version field processing

  Examples

    { Name = 'Adafruit MPU6050', VersionExpr = '>=2.2.4' } ->
    'Adafruit MPU6050 (>=2.2.4)'

    { Name = 'Marta', VersionExpr = '' } -> 'Marta'

    { Name = '', VersionExpr = '>=0.0.0' } -> ''
]]

-- Last mod.: 2024-03-03

return
  function(Dependency)
    assert_table(Dependency)

    local Name = Dependency.Name
    local VersionExpr = Dependency.VersionExpr

    assert_string(Name)
    assert_string(VersionExpr)

    local Result
    do
      Result = Name
      if (Result == '') then
        goto Continue
      end
      if (VersionExpr ~= '') then
        Result = Result .. ' (' .. VersionExpr .. ')'
      end
      ::Continue::
    end
    assert_string(Result)

    return Result
  end

--[[
  2024-02-25
  2024-03-04
]]
