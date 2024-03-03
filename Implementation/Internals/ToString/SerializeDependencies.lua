-- Serialize list of dependencies

--[[
  Input

    table

      Sequence of records in following format:

        Name: string
        VersionExpression: string

  Output

    string

      Serialized list of dependencies. CSV.

  Special cases

    If <Name> == ''
      Skip record processing
    If <VersionExpression> == ''
      Skip version field processing

    Empty table is serialized to empty string: ''
]]

-- Last mod.: 2024-03-03

return
  function(Dependencies)
    assert_table(Dependencies)

    local DepStrs = {}
    for _, DepRec in ipairs(Dependencies) do
      local Name = DepRec.Name
      local VersionExpr = DepRec.VersionExpression

      assert_string(Name)
      assert_string(VersionExpr)

      if (Name == '') then
        goto Continue
      end

      local DepStr = ''
      DepStr = DepStr .. Name
      if (VersionExpr ~= '') then
        DepStr = DepStr .. ' (' .. VersionExpr .. ')'
      end
      table.insert(DepStrs, DepStr)

      ::Continue::
    end

    local Result = table.concat(DepStrs, ', ')

    return Result
  end

--[[
  2024-02-25
]]
