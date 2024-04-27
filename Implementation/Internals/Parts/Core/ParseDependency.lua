-- Parse string with library name and optional dependency expression

--[[
  Input

    string

      Name ["(" VersionExpr ")"]

  Output

    table

      {
        Name: string
        VersionExpr: string
      }

  Examples

    'Adafruit MPU6050 (>=2.2.4)' ->
      { Name = 'Adafruit MPU6050', VersionExpr = '>=2.2.4' }

    ' A  ( >=0.0.0 ) ' -> { Name = 'A', VersionExpr = '>=0.0.0' }
    // We trim side spaces

    '(B(C))' -> { Name = '', VersionExpr = 'B(C)' }
    // We don't care about validity of library name and <VersionExpr> semantics
]]

-- Last mod.: 2024-03-28

local Trim = request('!.string.trim')
local RTrim = request('!.string.trim_tail')

return
  function(s)
    assert_string(s)

    local Result
    do
      s = Trim(s)

      -- Name is a string prefix until "("
      local NameFormatStr = '^[^(]+'
      local Name = string.match(s, NameFormatStr)
      Name = RTrim(Name)

      -- VersionExpr is a contents of balanced parenthesis ()
      local VersionExprFormatStr = '%b()'
      local VersionExpr = string.match(s, VersionExprFormatStr)
      if is_nil(VersionExpr) then
        VersionExpr = ''
      end
      -- Drop the external parenthesis
      if (string.len(VersionExpr) >= 2) then
        VersionExpr = string.sub(VersionExpr, 2, -2)
      end
      -- Drop spaces on sides
      VersionExpr = Trim(VersionExpr)

      Result = { Name = Name, VersionExpr = VersionExpr }
    end
    assert_table(Result)

    return Result
  end

--[[
  2024-03-03
  2024-04-04
  2024-04-24
]]
