-- Serialize table to "annotated strings" format

--[[
  Status: passed maiden flight
  Version: 1
  Last mod.: 2024-02-13
]]

--[[
  Signature is

    (Data: table [, KeysOrder: table]): string

  Expected <Data> format for each key-value is

    key: string
    value: string

  Nah, no integers, no booleans. Also no floats, tables, or userdata.

  If <KeysOrder> is present it's format expected to be a table
  sequence of key names (strings!).

  We just iterate over this sequence, getting values from <Data> and
  and serializing pairs by <SerializeKeyVal()>.

  We don't care about duplicate keys or omitted keys this way.

  If <KeysOrder> is not present, we will create it for suitable
  (string type) key-value pairs in <Data>.
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
