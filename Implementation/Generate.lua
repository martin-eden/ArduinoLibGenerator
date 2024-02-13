-- Generate internal data for ArdunoIDE library descriptor

--[[
  Status: writing
  Version: 1
  Last mod.: 2024-02-13
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
    repository=https://github.com/bblanchon/ArduinoJson.git
    license=MIT
]]

local AnnotatedLinesFormat = request('AnnotatedLines.Interface')

local AssertNoNewlines = request('AnnotatedLines.string.assert_no_newlines')

local SerializeAuthor =
  function(Author)
    assert_table(Author)
    AssertNoNewlines(Author.Name)
    return Author.Name
  end

local SerializeAuthors =
  function(Authors)
    assert_table(Authors)
    local Results = {}
    for _, Author in ipairs(Authors) do
      table.insert(Results, SerializeAuthor(Author))
    end
    local Result = table.concat(Results, ", ")
    return Result
  end

return
  function(self, Config)
    assert_table(Config)

    local Keyvals =
      {
        name = Config.What.Name,
        author = SerializeAuthors(Config.Who.Authors),
      }
    local KeysOrder = {'name', 'author'}

    local LibPropsStr = AnnotatedLinesFormat:Save(Keyvals, KeysOrder)

    assert_boolean(Config.How.ReadOnly)
    local ReadOnly = Config.How.ReadOnly

    return LibPropsStr, ReadOnly
  end
