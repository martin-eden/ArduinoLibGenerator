-- Parse ArduinoIDE "library.properties" to configuration Lua table

--[[
  Input

    string - contents of "library.properties" file

  Output

    table - table with data to save

      Example: { ['/tmp/lib_config.lua'] = 'return {}' }
]]

-- Last mod.: 2024-04-28

local AnnotatedLinesFormat = request('!.concepts.AnnotatedLines.Interface')
local StringFromLines = request('!.string.from_lines')

local CheckRequiredFields = request('Parts.CheckStructure_AnnotatedLines')
local CheckLibName = request('Parts.CheckLibraryName')

local ParsePersons = request('Parts.Persons.Unpack')
local ParseDependencies = request('Parts.Dependencies.Unpack')
local ParseArchitectures = request('Parts.Architectures.Unpack')

local TableToString = request('!.table.as_lua_code')

return
  function(LibProps_Str)
    assert_string(LibProps_Str)

    local Props
    do
      local Problems
      Props, Problems = AnnotatedLinesFormat.Load(LibProps_Str)
      if next(Problems) then
        print('Problems with annotated lines parsing --(')
        io.write(StringFromLines(Problems))
        print(')--')
      end
    end
    assert_table(Props)

    -- Check that we have data to convert:
    do
      local IsOkay, Messages = CheckRequiredFields(Props)
      if not IsOkay then
        print('Problems with "library.properties" data --(')
        io.write(StringFromLines(Messages))
        print(')--')
        return {}
      end
    end

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
          How =
            {
              Architectures = ParseArchitectures(Props.architectures),
              Dependencies = {},
            },
          Who =
            {
              Authors = ParsePersons(Props.author),
              Maintainers = ParsePersons(Props.maintainer),
            },
        }

      -- "depends" is optional field in spec but obligatory in our format
      if Props.depends then
        Config.How.Dependencies = ParseDependencies(Props.depends)
      end
    end
    assert_table(Config)

    -- Call that annoying name checker and continue:
    do
      local LibName = Config.What.Name
      local NameIsOkay, Complain = CheckLibName(LibName)
      if not NameIsOkay then
        local MessageFmt =
          'Library name "%s" does not conform to specification: %s'
        local Message = string.format(MessageFmt, LibName, Complain)
        print(Message)
      end
    end

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
