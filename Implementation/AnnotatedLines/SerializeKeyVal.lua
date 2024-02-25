-- Serialize key-value pair.

--[[
  Arguments

    string -- Key
      No newlines, no "=".

    string -- Value
      No newlines.

  Returns

    string
]]

local AssertNoNewlines = request('string.assert_no_newlines')
local AssertNotContains = request('string.assert_not_contains')

return
  function(self, Key, Value)
    assert_string(Key)
    AssertNoNewlines(Key)
    AssertNotContains(Key, '=')

    assert_string(Value)
    AssertNoNewlines(Value)

    local FormatStr = "%s=%s"
    local Result = string.format(FormatStr, Key, Value)

    return Result
  end

--[[
  2024-02-13
  2024-02-25
]]
