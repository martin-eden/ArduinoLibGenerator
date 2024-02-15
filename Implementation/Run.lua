-- Typical workflow for ArduinoLibGenerator

--[[
  Status: works
  Version: 2
  Last mod.: 2024-02-15
]]

--[[
  v Receives configuration file pathname and optional result directory path
  v if result directory is not specified, use default
  v Load configuration
  v Generate "library.properties" contents and get ReadOnly flag
  v Save results to files into results directory
]]

local DefaultResultsDir = 'Results/'

return
  function(self, ConfigurationPathName, ResultsDir)
    ResultsDir = ResultsDir or DefaultResultsDir
    assert_string(ResultsDir)

    local Configuration = self:LoadConfiguration(ConfigurationPathName)

    local LibPropsStr, ReadOnly = self:Generate(Configuration)

    self:SaveResults(LibPropsStr, ReadOnly, ResultsDir)
  end
