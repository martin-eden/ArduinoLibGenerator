-- Typical workflow for ArduinoLibGenerator

--[[
  Version: 4
  Last mod.: 2024-02-17
]]

--[[
  v Load configuration
  v Generate data (with filename)
  v Save save data to result directory
]]

local AddSlashToDirName = request('!.string.file_name.add_dir_postfix')

--[[
  Methods to parse/generate/compile "library.properties" were created
  before external caller became a class.

  So that methods are not exposed in caller's interface. Price of handy
  calls like "self:Load()" is that all methods now have access to all
  class data. And you can't understand what data they need without
  reading their code. Decomposing becomes harder.
]]

local LoadConfiguration = request('Internals.LoadConfiguration')
local Generate = request('Internals.Generate')
local SaveResults = request('Internals.SaveResults')

return
  function(self)
    local ConfigurationPathName = self.ConfigurationFilename
    local ResultsDir = self.ResultsDir

    assert_string(ConfigurationPathName)
    assert_string(ResultsDir)

    ResultsDir = AddSlashToDirName(ResultsDir)

    local Configuration = LoadConfiguration(ConfigurationPathName)
    assert_table(Configuration)

    local DirTree_Create = Generate(Configuration)

    SaveResults(DirTree_Create, ResultsDir)
  end

--[[
  2024-02-17
  2024-02-29
]]
