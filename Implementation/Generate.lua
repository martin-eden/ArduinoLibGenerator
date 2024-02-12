-- Generate internal data for ArdunoIDE library descriptor

--[[
  Status: in writing
  Version: 0
  Last mod.: 2024-02-11
]]

local TestResult =
[[
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

return
  function(self, Configuration)
    assert_table(Configuration)

    local Result =
      {
        Data = TestResult,
      }

    return Result
  end
