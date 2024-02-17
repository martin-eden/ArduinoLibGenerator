-- Typical workflow for ArduinoLibGenerator

--[[
  Status: works
  Version: 3
  Last mod.: 2024-02-17
]]

--[[
  v Receives configuration file pathname and optional result directory path
  v Load configuration
  v Generate list of files to create and remove
  v Save results to files into result directory
]]

return
  function(self, ConfigurationPathName, ResultsDir)
    assert_string(ConfigurationPathName)
    assert_string(ResultsDir)

    local Configuration = self:LoadConfiguration(ConfigurationPathName)
    assert_table(Configuration)

    local DirTree_Create, DirTree_Remove = self:Generate(Configuration)

    self:SaveResults(DirTree_Create, DirTree_Remove, ResultsDir)
  end
