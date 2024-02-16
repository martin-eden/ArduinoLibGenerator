-- Generate internal data for ArdunoIDE library descriptor

--[[
  Status: writing
  Version: 1
  Last mod.: 2024-02-16
]]

--[[
  Reference document:

    Arduino CLI: Library specification

      https://arduino.github.io/arduino-cli/0.35/library-specification/#15-library-format-rev-22
]]

--[[
  Not supported

  * keywords.txt

    I'm not gonna support generation of "keywords.txt" file at all.
    Murky specification, forced .tsv format, dead-end toolpath.

    It's 2024 here and I hope ArduinoIDE team will find a means
    to determine name/type of code entities in this century.
]]

--[[
  Sample library.properties:

    name=ArduinoJson
    version=7.0.3
    author=Benoit Blanchon <blog.benoitblanchon.fr>
    maintainer=Benoit Blanchon <blog.benoitblanchon.fr>
    sentence=A simple and efficient JSON library for embedded C++.
    paragraph=⭐ 6463 stars on GitHub! Supports serialization, deserialization, MessagePack, streams, filtering, and more. Fully tested and documented.
    category=Data Processing
    url=https://arduinojson.org/?utm_source=meta&utm_medium=library.properties
    architectures=*
]]

local AnnotatedLinesFormat = request('AnnotatedLines.Interface')

local AssertNoNewlines = request('AnnotatedLines.string.assert_no_newlines')

--[[
  Check library name.

  Excerpts from

    https://arduino.github.io/arduino-cli/0.35/library-specification/#libraryproperties-file-format

  1. Library names must contain only basic letters (A-Z or a-z) and
    numbers (0-9), spaces ( ), underscores (_), dots (.) and
    dashes (-).

  2. They must start with a letter or number.

  3. They must contain at least one letter.

  4. Note that libraries with a name value starting with Arduino will
    no longer be allowed addition to the Library Manager index as
    these names are now reserved for official Arduino libraries.
]]
local SerializeLibName =
  function(LibName)
    assert_string(LibName)

    -- (1) and (2) are covered by <NamePattern>
    local NamePattern = '^[%a%d][%a%d _.%-]*$'
    local MatchesPattern = string.match(LibName, NamePattern)
    if not MatchesPattern then
      local ErrorMsgFmt =
        "Library name doesn't match library name pattern.\n" ..
        '  Library name: %s\n' ..
        '  Pattern: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName, NamePattern)
      error(ErrorMsg)
    end

    -- (3) has letter
    local HasLetter = (string.find(LibName, '%a') ~= nil)
    if not HasLetter then
      local ErrorMsgFmt =
        'Library name must contain letter.\n' ..
        '  Library name: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName)
      error(ErrorMsg)
    end

    -- (4) not starts with "Arduino"
    --[[
      Requirement (4) quite badly formulated as "ARDUINO" and "arduino"
      will pass it.
    ]]
    local StartsWithArduino = (string.find(LibName, '^Arduino') ~= nil)
    if StartsWithArduino then
      local ErrorMsgFmt =
        'Library name should not start with "Arduino".\n' ..
        '  Library name: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName)
      error(ErrorMsg)
    end

    return LibName
  end

local SerializePerson =
  function(Person)
    assert_table(Person)
    AssertNoNewlines(Person.Name)
    return Person.Name
  end

local SerializePersons =
  function(Persons)
    assert_table(Persons)
    local Results = {}
    for _, Person in ipairs(Persons) do
      table.insert(Results, SerializePerson(Person))
    end
    local Result = table.concat(Results, ", ")
    return Result
  end

return
  function(self, Config)
    assert_table(Config)

    local Keyvals =
      {
        name = SerializeLibName(Config.What.Name),
        version = Config.What.Version,
        category = Config.What.Category,
        architectures = table.concat(Config.How.Architectures, ','),
        sentence = Config.What.Description,
        paragraph = Config.What.Description_Continued,
        url = Config.What.MoreInfo_Url,
        author = SerializePersons(Config.Who.Authors),
        maintainer = SerializePersons(Config.Who.Maintainers),
      }

    local KeysOrder =
      {
        'name',
        'version',
        'category',
        'architectures',
        'sentence',
        'paragraph',
        'url',
        'author',
        'maintainer',
      }

    --[[
      Do a pre-flight format check before serialization.

      We are expected to have string value for every mentioned key.

      Currently serialization method will raise error if key-value are
      not strings (or if they contain newlines). So this pass is not
      essential. Just for better error message for common case of
      nil value.
    ]]
    for _, Key in ipairs(KeysOrder) do
      assert_string(Key)

      local Value = Keyvals[Key]
      if not is_string(Value) then
        if is_nil(Value) then
          local ErrorMsgFmt = 'No value for key %q.'
          local ErrorMsg = string.format(ErrorMsgFmt, Key)
          error(ErrorMsg)
        end
        local ErrorMsgFmt = 'Value is not a string. (Key: %q, Value: %q)'
        local ErrorMsg = string.format(ErrorMsgFmt, Key, tostring(Value))
        error(ErrorMsg)
      end
    end

    --[[
      Here we are passing two tables to serializer. If he's not happy
      he will blow with error().
    ]]
    local LibPropsStr = AnnotatedLinesFormat:Save(Keyvals, KeysOrder)

    assert_boolean(Config.How.ReadOnly)
    local ReadOnly = Config.How.ReadOnly

    return LibPropsStr, ReadOnly
  end
