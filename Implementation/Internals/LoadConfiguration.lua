-- Load and process configuration

--[[
  Version: 1
  Last mod.: 2024-02-29
]]

local FileExists = request('!.file_system.file.exists')

return
  function(ConfigPathName)
    if not FileExists(ConfigPathName) then
      local ErrorMsg =
        ([[Configuration file "%s" does not exist.]]):
        format(ConfigPathName)

      error(ErrorMsg)
    end

    local Config = dofile(ConfigPathName)

    if not is_table(Config) then
      local ErrorMsg =
        ('Results of execution configuration file "%s" is %s not a Lua table.'):
        format(ConfigPathName, type(Config))

      error(ErrorMsg)
    end

    return Config
  end

--[[
  2024-02-11
  2024-02-29
]]
