-- Typical workflow for ArduinoLibGenerator

--[[
  Version: 4
  Last mod.: 2024-03-03
]]

--[[
  v Load configuration
  v Generate data (with filename)
  v Save save data to results directory
]]

--[[
  Methods to parse/generate/compile "library.properties" were created
  before external caller became a class.

  So that methods are not exposed in caller's interface. Price of handy
  calls like "self:Load()" is that all methods now have access to all
  class data. And you can't understand what data they need without
  reading their code. Decomposing becomes harder.
]]

local LoadConfiguration = request('Internals.LoadConfiguration')
local Parse = request('Internals.Parse')
local Serialize = request('Internals.Serialize')
local SaveResults = request('Internals.SaveResults')

return
  function(self)
    local ConfigurationPathName = self.ConfigurationFilename
    local ResultsDir = self.ResultsDir
    local DoDecompile = self.DoDecompile

    assert_string(ConfigurationPathName)
    assert_string(ResultsDir)
    assert_boolean(DoDecompile)

    do
      local Configuration = LoadConfiguration(ConfigurationPathName)
      assert_string(Configuration)

      local DirTree_Create
      if DoDecompile then
        DirTree_Create = Parse(Configuration)
      else
        DirTree_Create = Serialize(Configuration)
      end
      assert_table(DirTree_Create)

      SaveResults(DirTree_Create, ResultsDir)
    end
  end

--[[
  2024-02-17
  2024-02-29
  2024-03-03
]]
