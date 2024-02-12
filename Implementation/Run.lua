-- Entry point

--[[
  Status: in writing
  Version: 0
  Last mod.: 2024-02-11
]]

--[[
  v Load configuration
  v Generate "library.properties"
  v Save result
]]

return
  function(self, ConfigurationPathName)
    local Configuration = self:LoadConfiguration(ConfigurationPathName)

    local Result = self:Generate(Configuration)

    self:SaveResults(Result)
  end
