-- Generate internal data for ArdunoIDE library descriptor file

--[[
  Version: 4
  Last mod.: 2024-02-29
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

      It's 2024 here and I hope ArduinoIDE team will find means
      to determine name/type of code entities in this century.

    * ".development" flag file

      Presence of this file assumes that you can change library source
      files and examples.

      But practically it's unusable as in ArduinoIDE 2.3.1 you can't
      save them.

      (Originally I've implemented logic for creation of this file.
      But dropping it now. Less is better.)
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

local AnnotatedLinesFormat = request('!.concepts.AnnotatedLines.Interface')

local SerializeLibName = request('ToString.SerializeLibName')
local SerializePersons = request('ToString.SerializePersons')
local SerializeDependencies =  request('ToString.SerializeDependencies')

return
  function(Config)
    assert_table(Config)

    local LibProps_Str = ''
    do
      local Lines = {}

      local Add =
        function(Key, Value)
          local Line = AnnotatedLinesFormat.SerializeKeyVal(Key, Value)
          table.insert(Lines, Line)
        end

      Add('name', SerializeLibName(Config.What.Name))
      Add('version', Config.What.Version)
      Add('category', Config.What.Category)
      Add('architectures', table.concat(Config.How.Architectures, ','))
      Add('sentence', Config.What.Description)
      Add('paragraph', Config.What.Description_Continued)
      Add('url', Config.What.MoreInfo_Url)
      Add('author', SerializePersons(Config.Who.Authors))
      Add('maintainer', SerializePersons(Config.Who.Maintainers))

      local Depends_Str = SerializeDependencies(Config.How.Dependencies)
      if (Depends_Str ~= '') then
        Add('depends', Depends_Str)
      end

      LibProps_Str = table.concat(Lines, '\n')
    end

    local Result_Create = {}

    Result_Create['library.properties'] = LibProps_Str

    return Result_Create
  end

--[[
  2024-02-16
  2024-02-25
  2024-02-29
]]
