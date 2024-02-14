-- Save results

--[[
  Status: fine
  Version: 2
  Last mod.: 2024-02-14
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
local LibPropsCreatedMsg = [[Created "%s" in "%s".]]
local DevFlagFilePlaced = [[Created "%s" flag file in "%s".]]

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
    print(string.format(LibPropsCreatedMsg, LibPropsFileName, ResultsDir))

    local DevFlagPathName = ResultsDir .. DevFlagFileName
    RemoveFile(DevFlagPathName)
    if not ReadOnly then
      CreateFile(DevFlagPathName)
      print(string.format(DevFlagFilePlaced, DevFlagFileName, ResultsDir))
    end
  end
