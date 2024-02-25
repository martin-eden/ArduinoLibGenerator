-- Serialize list of dependencies

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
