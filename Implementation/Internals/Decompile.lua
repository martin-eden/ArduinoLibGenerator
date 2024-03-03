-- Parse ArduinoIDE "library.properties" to configuration Lua table

--[[
  Input

    string - contents of "library.properties" file

  Output

    table - table with data to save

      Example: { ['/tmp/lib_config.lua'] = 'return {}' }
]]

-- Last mod.: 2024-03-03

local AnnotatedLinesFormat = request('!.concepts.AnnotatedLines.Interface')
local StringFromLines = request('!.string.from_lines')
local TableToString = request('!.table.as_lua_code')

return
  function(LibProps_Str)
    assert_string(LibProps_Str)

    local Props
    do
      local Problems
      Props, Problems = AnnotatedLinesFormat.Load(LibProps_Str)
      if next(Problems) then
        print('Problems with parsing:')
        io.write(StringFromLines(Problems))
      end
    end
    assert_table(Props)

    local Config
    do
      Config =
        {
          What =
            {
              Name = Props.name,
              Version = Props.version,
              Category = Props.category,
              Description = Props.sentence,
              Description_Continued = Props.paragraph,
              MoreInfo_Url = Props.url,
            },
          How = {},
          Who = {},
        }
    end
    assert_table(Config)

    local Config_Str
    do
      Config_Str = TableToString(Config)
    end
    assert_string(Config_Str)

    local Result
    do
      Result = { ['library.configuration.lua'] = Config_Str }
    end
    assert_table(Result)

    return Result
  end

--[[
  2024-03-03
]]
