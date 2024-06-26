-- Generate ArdunoIDE library descriptor

--[[
  Input

    string - contents of ".lua" configuration file

  Output

    table - table with data to save

      Example: { ['/tmp/test.txt'] = 'Test file contents.' }
]]

--[[
  Reference document:

    Arduino CLI: Library specification

      https://arduino.github.io/arduino-cli/0.35/library-specification/#15-library-format-rev-22

  Not supported

    * keywords.txt

      I'm not gonna support generation of "keywords.txt" file at all.
      Murky specification, forced .tsv format, dead-end toolpath.

      It's 2024 here and I hope ArduinoIDE team will find a means
      to determine name/type of code entities in this century.

    * ".development" flag file

      Presence of this file assumes that you can change library source
      files and examples.

      But practically it's unusable as in ArduinoIDE 2.3.1 you can't
      save them.

      (Originally I've implemented support for this flag. But then
      dropped it. Less is better.)
]]

-- Last mod.: 2024-04-28

local AnnotatedLinesFormat = request('!.concepts.AnnotatedLines.Interface')
local StringFromLines = request('!.string.from_lines')

local CheckRequiredFields = request('Parts.CheckStructure_Lua')
local CheckLibName = request('Parts.CheckLibraryName')

local SerializePersons = request('Parts.Persons.Pack')
local SerializeDependencies = request('Parts.Dependencies.Pack')
local SerializeArchitectures = request('Parts.Architectures.Pack')

return
  function(ConfigContents)
    assert_string(ConfigContents)

    local Config
    do
      -- Security note (1).
      local ConfigChunk, ErrorMsg = load(ConfigContents)

      if not is_function(ConfigChunk) then
        assert_string(ErrorMsg)
        local ErrorMsgFmt = 'Error while parsing configuration: %s.'
        local ErrorMsg = string.format(ErrorMsgFmt, ErrorMsg)
        error(ErrorMsg)
      end
      assert_function(ConfigChunk)

      Config = ConfigChunk()

      if not is_table(Config) then
        local ErrorMsgFmt =
          'Result of execution configuration is %s, not a Lua table.'
        local ErrorMsg = string.format(ErrorMsgFmt, type(Config))
        error(ErrorMsg)
      end

      local IsOkay, Messages = CheckRequiredFields(Config)
      if not IsOkay then
        print('Problems with loaded Lua structure --(')
        io.write(StringFromLines(Messages))
        print(')--')
        return {}
      end
    end
    assert_table(Config)

    --[[
      Check library name for formal requirements.
      If it does not conform to official specification,
      just print message and continue. Hello, "ArduinoJson"!.
    ]]
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

    local LibProps_Str
    do
      local KeysOrder =
        {
          'name', 'version', 'category', 'architectures', 'sentence',
          'paragraph', 'url', 'author', 'maintainer', 'depends',
        }

      local LibProps =
        {
          name = Config.What.Name,
          version = Config.What.Version,
          category = Config.What.Category,
          architectures = SerializeArchitectures(Config.How.Architectures),
          sentence = Config.What.Description,
          paragraph = Config.What.Description_Continued,
          url = Config.What.MoreInfo_Url,
          author = SerializePersons(Config.Who.Authors),
          maintainer = SerializePersons(Config.Who.Maintainers),
        }

      -- "depends" is optional field. Include it only we have content:
      local DependsStr = SerializeDependencies(Config.How.Dependencies)
      if (DependsStr ~= '') then
        LibProps.depends = DependsStr
      end

      LibProps_Str = AnnotatedLinesFormat.Save(LibProps, KeysOrder)
    end
    assert_string(LibProps_Str)

    return { ['library.properties'] = LibProps_Str }
  end

--[[
  [1]: Security note.

    Here we have user Lua code in a string.

    We are going to compile it to function and call that function to
    get config table.

    We can set environment for code in 4th parameter of load(). For
    example passing "{require = require}" will limit it's environment
    only to "require()". But that's enough for any evil code.

    The user is me and I want "require()" and "print()" and maybe all
    "math.". And most probably some other things.

    I'm not going to build sandbox for myself. I'm responsible for what
    my code is doing on my machine. Amen.
]]

--[[
  2024-02-16
  2024-02-25
  2024-02-29
  2024-03-03
  2024-03-05
]]
