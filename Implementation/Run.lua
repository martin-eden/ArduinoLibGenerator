-- Entry point

--[[
  Status: in writing
  Version: 1
  Last mod.: 2024-02-13
]]

--[[
  v Load configuration
  v Generate "library.properties"
    | Maybe place ".development" file to make examples editable
  v Save result
]]

return
  function(self, ConfigurationPathName)
    local Configuration = self:LoadConfiguration(ConfigurationPathName)

    local LibPropsStr, ReadOnly = self:Generate(Configuration)

    self:SaveResults(LibPropsStr, ReadOnly)
  end
