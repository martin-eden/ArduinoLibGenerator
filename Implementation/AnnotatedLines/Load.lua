-- Parse annotated strings format

--[[
  No duplicate keys in output. We're keeping the last value.

  Sample input

    a=a 1
    b=b 1
    a=a 2

  Sample output

    {
      a = 'a 2',
      b = 'b 1',
    }
]]

--[[
  Version: 1
  Last mod.: 2024-02-15
]]

local SplitStringToLines = request('!.string.split_to_lines')
local IterateLines = request('!.string.lines')

return
  function(self, DataString)
    assert_string(DataString)

    local Result = {}
    for _, Line in IterateLines(DataString) do
      local Key, Value = ParseLine(Line)

      assert_string(Key)
      assert_string(Value)
      Result[Key] = Value
    end

    return Result
  end
