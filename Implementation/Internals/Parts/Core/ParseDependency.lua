-- Parse string dependency

--[[
  Input

    string

      library_name ["(" version_expression ")"]

  Output

    table

      {
        Name: string
        VersionExpr: string
      }

  Examples

    'Adafruit MPU6050 (>=2.2.4)' ->
      { Name = 'Adafruit MPU6050', VersionExpr = '>=2.2.4' }

    ' A  (>=0.0.0) ' -> { Name = 'A', VersionExpr = '>=0.0.0' }
    // We trim parts

    '(B)' -> { Name = '', VersionExpr = 'B' }
    // We don't care about valid library name and <VersionExpr> here
]]

-- Last mod.: 2024-03-04

return
  function(s)
    assert_string(s)

    local Result
    do
      Result = { Name = '', VersionExpr = '' }
    end
    assert_table(Result)

    return Result
  end

--[[
  2024-03-03
  2024-04-04
]]
