-- Serialize key-value pair

--[[
  Input

    Key: string
      No newlines, no "=".

    Value: string
      No newlines.

  Output

    string
]]

-- Last mod.: 2024-02-13

local AssertNoNewlines = request('string.assert_no_newlines')
local AssertNotContains = request('string.assert_not_contains')

return
  function(self, Key, Value)
    assert_string(Key)
    AssertNoNewlines(Key)
    AssertNotContains(Key, '=')

    assert_string(Value)
    AssertNoNewlines(Value)

    local Result =
      string.format('%s=%s', Key, Value)

    return Result
  end
