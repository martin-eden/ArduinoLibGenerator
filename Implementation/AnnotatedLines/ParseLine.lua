-- Parse line to key-value

--[[
  Mind the spaces.

  Sample input

    'a= A == a'

  Sample output

    'a', ' A == a'
]]

--[[
  Version: 1
  Last mod.: 2024-02-15
]]

local ParsePattern = '(.-)=(.+)'

return
  function(Line)
    assert_string(Line)

    local Key, Value

    Key, Value = string.match(Line, ParsePattern)

    return Key, Value
  end
