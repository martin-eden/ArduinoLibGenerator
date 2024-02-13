-- Save results

--[[
  Status: passed maiden flight
  Version: 1
  Last mod.: 2024-02-13
]]

local ResultsDir = 'Results/'
local LibPropsFileName = 'library.properties'
local DevFlagFileName = '.development'

local DirectoryExists = request('!.directory.exists')
local CreateDirectory = request('!.directory.create')
local CreateFile = request('!.file.create')
local SaveToFile = request('!.string.save_to_file')
local RemoveFile = request('!.file.remove')

local CreateDirectoryErrorMsg = [[
Cannot create directory for result files.
  Requested directory: "%s"
  Current directory: "%s"
]]

return
  function(self, LibPropsStr, ReadOnly)
    assert_string(LibPropsStr)
    assert_boolean(ReadOnly)

    if not DirectoryExists(ResultsDir) then
      if not CreateDirectory(ResultsDir) then
        local ErrorMsg =
          string.format(CreateDirectoryErrorMsg, ResultsDir, CurrentDir)
        error(ErrorMsg)
      end
    end

    local LibPropsPathName = ResultsDir .. LibPropsFileName
    SaveToFile(LibPropsPathName, LibPropsStr)

    local DevFlagPathName = ResultsDir .. DevFlagFileName
    RemoveFile(DevFlagPathName)
    if not ReadOnly then
      CreateFile(DevFlagPathName)
    end
  end
