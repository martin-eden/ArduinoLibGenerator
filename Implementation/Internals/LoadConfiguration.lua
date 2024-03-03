-- Load and process configuration

--[[
  Input

    string - pathname to file

  Output

    string - contents of file

  As with [SaveResults], no processing here. Only file I/O business.
]]

-- Last mod.: 2024-03-03

local FileExists = request('!.file_system.file.exists')
local FileAsString = request('!.file_system.file.as_string')

return
  function(ConfigPathName)
    if not FileExists(ConfigPathName) then
      local ErrorMsg =
        ([[Configuration file "%s" does not exist.]]):
        format(ConfigPathName)

      error(ErrorMsg)
    end

    local ConfigContents = FileAsString(ConfigPathName)

    return ConfigContents
  end

--[[
  2024-02-11
  2024-02-29
  2024-03-03
]]
