-- Generate internal data for ArdunoIDE library descriptor file

--[[
  Version: 3
  Last mod.: 2024-02-25
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

  Not recommended (for ArduinoIDE 2.3.1)

    * How.ReadOnly == false

      Changeable libraries not actually supported in this ArduinoIDE.

      Setting <ReadOnly> to false creates ".development" flag file.
      You can open and change files from "examples/" directory of library.
      You can even compile and upload them.

      But you can not save them! IDE will offer to save example as new
      sketch.

      So I do recommend keeping ReadOnly == true.
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

local SerializeLibName = request('ToString.SerializeLibName')
local SerializePersons = request('ToString.SerializePersons')
local SerializeDependencies =  request('ToString.SerializeDependencies')

return
  function(self, Config)
    assert_table(Config)

    local LibProps_Str = ''
    do
      local Lines = {}

      local Add =
        function(Key, Value)
          local Line = AnnotatedLinesFormat:SerializeKeyVal(Key, Value)
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

    local Result_Create, Result_Remove = {}, {}
    do
      Result_Create['library.properties'] = LibProps_Str

      -- Library is writable when ".development" file is present:
      do
        assert_boolean(Config.How.ReadOnly)
        local ReadOnly = Config.How.ReadOnly

        local Devflag_Fname = '.development'
        if ReadOnly then
          Result_Remove[Devflag_Fname] = ''
        elseif not ReadOnly then
          Result_Create[Devflag_Fname] = ''
        end
      end
    end

    return Result_Create, Result_Remove
  end

--[[
  2024-02-16
  2024-02-25
]]
