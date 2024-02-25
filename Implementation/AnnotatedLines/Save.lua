-- Serialize table to "annotated strings" format

--[[
  Status: passed maiden flight
  Version: 1
  Last mod.: 2024-02-15
]]

--[[
  Arguments

      table -- Data
    | table -- KeysOrder

  Returns

    string

  --

  Data:

    string: string, ...
    ~~~~~~~ ~~~~~~
      key    value

  KeysOrder:

    string, ...
    ~~~~~~~~
    key name

  --

  If <KeysOrder> is not present
    Create it for string key-value pairs in <Data>

  Iterate <Key> over <KeysOrder>
    // We don't care about duplicate or omitted keys
    <Value> = <Data>.<Key>
    <Line> = Serialize(<Key>, <Value>)
    <Result> = <Result> + '\n' + <Line>
]]

local GetKeys = request('!.table.get_keys')
local CompareKeys = request('!.table.ordered_pass.default_comparator')

return
  function(self, Data, KeysOrder)
    assert_table(Data)

    --[[
      When no key order is given, get all keys and sort them.

      We will filter suitable key-values at serialization stage.
      I don't want to meddle with table.remove() here.
    ]]
    if is_nil(KeysOrder) then
      KeysOrder = GetKeys(Data)
      table.sort(KeysOrder, CompareKeys)
    end

    assert_table(KeysOrder)

    local Result = ''

    local Lines = {}

    for _, Key in ipairs(KeysOrder) do
      local Value = Data[Key]
      if is_string(Key) and is_string(Value) then
        local Line = self:SerializeKeyVal(Key, Value)
        table.insert(Lines, Line)
      end
    end

    Result = table.concat(Lines, '\n')

    return Result
  end

--[[
  2024-02-13
  2024-02-25
]]
